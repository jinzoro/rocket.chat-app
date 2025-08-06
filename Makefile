.PHONY: help start stop restart logs status clean setup backup restore
.DEFAULT_GOAL := help

# Colors for output
RED := \033[0;31m
GREEN := \033[0;32m
YELLOW := \033[1;33m
BLUE := \033[0;34m
NC := \033[0m # No Color

help: ## Show this help message
	@echo "$(BLUE)Rocket.Chat Management$(NC)"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "$(YELLOW)%-15s$(NC) %s\n", $$1, $$2}'

setup: ## Initial setup - copy .env.example to .env
	@if [ ! -f .env ]; then \
		echo "$(YELLOW)Creating .env file from .env.example$(NC)"; \
		cp .env.example .env; \
		echo "$(RED)⚠️  Please edit .env file and set your passwords!$(NC)"; \
	else \
		echo "$(GREEN).env file already exists$(NC)"; \
	fi

start: ## Start all services
	@if [ ! -f .env ]; then \
		echo "$(YELLOW)No .env file found, creating from .env.example$(NC)"; \
		cp .env.example .env; \
		echo "$(RED)⚠️  Using default passwords! Edit .env file for security!$(NC)"; \
	fi
	@echo "$(GREEN)Starting Rocket.Chat application...$(NC)"
	@docker-compose up -d
	@echo "$(GREEN)✅ Application started! Access it at http://localhost:3000$(NC)"

stop: ## Stop all services
	@echo "$(YELLOW)Stopping Rocket.Chat application...$(NC)"
	@docker-compose down
	@echo "$(GREEN)✅ Application stopped$(NC)"

restart: stop start ## Restart all services

logs: ## View logs from all services
	@docker-compose logs -f

logs-app: ## View logs from Rocket.Chat app only
	@docker-compose logs -f rocketchat

logs-db: ## View logs from MongoDB only
	@docker-compose logs -f mongodb

status: ## Show status of all services
	@docker-compose ps

health: ## Check health of all services
	@echo "$(BLUE)Checking service health...$(NC)"
	@docker-compose ps --format "table {{.Name}}\t{{.Status}}\t{{.Ports}}"

update: ## Pull latest images and restart
	@echo "$(YELLOW)Updating Docker images...$(NC)"
	@docker-compose pull
	@docker-compose up -d
	@echo "$(GREEN)✅ Update complete$(NC)"

clean: ## Remove stopped containers and unused images
	@echo "$(YELLOW)Cleaning up Docker resources...$(NC)"
	@docker-compose down
	@docker system prune -f
	@echo "$(GREEN)✅ Cleanup complete$(NC)"

backup: ## Create backup of data volumes
	@echo "$(YELLOW)Creating backup...$(NC)"
	@mkdir -p backups
	@docker run --rm -v rocketchat-app_mongodb_data:/data -v $(PWD)/backups:/backup alpine tar czf /backup/mongodb-data-$(shell date +%Y%m%d-%H%M%S).tar.gz -C /data .
	@docker run --rm -v rocketchat-app_rocketchat_uploads:/data -v $(PWD)/backups:/backup alpine tar czf /backup/rocketchat-uploads-$(shell date +%Y%m%d-%H%M%S).tar.gz -C /data .
	@echo "$(GREEN)✅ Backup created in backups/ directory$(NC)"

shell-app: ## Open shell in Rocket.Chat container
	@docker-compose exec rocketchat /bin/bash

shell-db: ## Open shell in MongoDB container
	@docker-compose exec mongodb mongosh

mongo-shell: ## Open MongoDB shell with authentication
	@docker-compose exec mongodb mongosh --authenticationDatabase admin -u $$(grep MONGO_ROOT_USER .env | cut -d '=' -f2) -p

init-replica: ## Manually initialize MongoDB replica set (if needed)
	@echo "$(YELLOW)Checking and initializing MongoDB replica set...$(NC)"
	@docker-compose exec mongodb mongosh --quiet --eval \
		"try { \
		  if (rs.status().ok) { \
		    print('Replica set already initialized and healthy'); \
		  } else { \
		    rs.initiate({_id: 'rs0', members: [{_id: 0, host: 'mongodb:27017'}]}); \
		    print('Replica set initialized successfully'); \
		  } \
		} catch(e) { \
		  if (e.message.includes('already initialized')) { \
		    print('Replica set already initialized'); \
		  } else { \
		    rs.initiate({_id: 'rs0', members: [{_id: 0, host: 'mongodb:27017'}]}); \
		    print('Replica set initialized'); \
		  } \
		}"
	@echo "$(GREEN)✅ Replica set check/initialization complete$(NC)"

reset: ## ⚠️ DANGER: Remove all data and start fresh
	@echo "$(RED)⚠️  This will delete ALL data! Are you sure? [y/N]$(NC)" && read ans && [ $${ans:-N} = y ]
	@docker-compose down -v
	@docker-compose up -d
	@echo "$(GREEN)✅ Application reset complete$(NC)"

admin-info: ## Show admin user creation info
	@echo "$(BLUE)Admin User Information:$(NC)"
	@echo "To create an admin user automatically, add these to your .env file:"
	@echo "$(YELLOW)ADMIN_USERNAME=admin$(NC)"
	@echo "$(YELLOW)ADMIN_PASS=your_secure_password$(NC)"
	@echo "$(YELLOW)ADMIN_EMAIL=admin@yourdomain.com$(NC)"
	@echo ""
	@echo "Then restart with: $(GREEN)make restart$(NC)"
