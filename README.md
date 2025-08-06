# Rocket.Chat Application

[![License](https://img.shields.io/badge/License-JIN-blue.svg)](./LICENSE)
[![Docker](https://img.shields.io/badge/Docker-Ready-2496ED?logo=docker&logoColor=white)](https://www.docker.com/)
[![Docker Compose](https://img.shields.io/badge/Docker%20Compose-3.8-2496ED?logo=docker&logoColor=white)](https://docs.docker.com/compose/)
[![Rocket.Chat](https://img.shields.io/badge/Rocket.Chat-7.9.0-F5455C?logo=rocket.chat&logoColor=white)](https://rocket.chat/)
[![MongoDB](https://img.shields.io/badge/MongoDB-8.0.12-47A248?logo=mongodb&logoColor=white)](https://www.mongodb.com/)
[![Traefik](https://img.shields.io/badge/Traefik-v2.10-16B6D6?logo=traefik&logoColor=white)](https://traefik.io/)
[![Trivy](https://img.shields.io/badge/Trivy-Scan-00A9E5?logo=trivy&logoColor=white)](https://github.com/aquasecurity/trivy)
[![Watchtower](https://img.shields.io/badge/Watchtower-Auto--Update-2E4053?logo=containrrr&logoColor=white)](https://containrrr.dev/watchtower/)
[![Make](https://img.shields.io/badge/Make-Enabled-427819?logo=gnu&logoColor=white)](https://www.gnu.org/software/make/)
[![Health Checks](https://img.shields.io/badge/Health%20Checks-✓-00D26A)]()
[![Production Ready](https://img.shields.io/badge/Production-Ready-00D26A)]()
[![Security](https://img.shields.io/badge/Security-Hardened-FF6B35)]()
[![Backup](https://img.shields.io/badge/Backup-Automated-4285F4)]()
[![Platform](https://img.shields.io/badge/Platform-Linux%20%7C%20macOS%20%7C%20Windows-lightgrey)]()
[![Shell](https://img.shields.io/badge/Shell-Bash%20%7C%20Zsh-1f425f.svg?logo=gnu-bash&logoColor=white)]()
[![Free](https://img.shields.io/badge/Price-Free-00D26A?logo=opensourceinitiative&logoColor=white)]()
[![Open Source](https://img.shields.io/badge/Open%20Source-♥-red?logo=opensource&logoColor=white)](https://opensource.org/)
[![Maintained](https://img.shields.io/badge/Maintained-Yes-00D26A)]()
[![PRs Welcome](https://img.shields.io/badge/PRs-Welcome-brightgreen.svg)]()

This Docker Compose setup provides a complete Rocket.Chat application with MongoDB database, featuring environment-based configuration, health checks, and easy management tools.

## 🚀 What's Included

- **Rocket.Chat Community Edition**: Open-source chat and collaboration platform
- **MongoDB 6.0**: Database with replica set for optimal performance
- **Environment Variables**: Secure configuration management
- **Health Checks**: Automatic service monitoring
- **Makefile**: Easy management commands
- **Production Ready**: Additional production configuration available

## ⚡ Quick Start

### Method 1: Using Make (Recommended)
```bash
# Initial setup
make setup
# Edit .env file with your secure passwords
nano .env
# Start the application
make start
```

### Method 2: Manual Setup
1. **Configure environment:**
   ```bash
   cp .env.example .env
   # Edit .env and set secure passwords
   nano .env
   ```

2. **Start the application:**
   ```bash
   docker-compose up -d
   ```

3. **Access Rocket.Chat:**
   Open your browser and go to: http://localhost:3000

4. **First-time setup:**
   - Complete the setup wizard (if not disabled)
   - Create your admin account
   - Configure your workspace
   - Start chatting!

## 🛠️ Management Commands

### Using Make (Recommended)
```bash
make help          # Show all available commands
make start         # Start all services
make stop          # Stop all services
make restart       # Restart all services
make logs          # View logs from all services
make logs-app      # View logs from Rocket.Chat only
make logs-db       # View logs from MongoDB only
make status        # Show service status
make health        # Check service health
make update        # Update images and restart
make backup        # Create backup of data
make clean         # Clean up Docker resources
make shell-app     # Open shell in Rocket.Chat container
make shell-db      # Open MongoDB shell
make mongo-shell   # Open authenticated MongoDB shell
make init-replica  # Initialize replica set (if needed)
make reset         # ⚠️ Reset all data (destructive)
make admin-info    # Show admin user creation info
```

### Using Docker Compose Directly
```bash
docker-compose up -d        # Start services
docker-compose down         # Stop services
docker-compose logs -f      # View logs
docker-compose restart      # Restart services
docker-compose pull && docker-compose up -d  # Update
```

## 🎯 Rocket.Chat Features

### ✅ **What You Get (Community Edition):**
- **50 users** and **unlimited messages**
- **File sharing & search** 
- **Audio & video calls** (WebRTC)
- **Screen sharing**
- **Desktop, web & mobile apps**
- **Integrations & webhooks** 
- **Bots and slash commands**
- **Message threading & reactions**
- **Multiple authentication methods**
- **Real-time translation**
- **Apps marketplace**
- **Community support**

### 💼 **Enterprise Features (Paid):**
- **Omnichannel** (customer service)
- **Advanced security** (2FA, E2E encryption)
- **LDAP/Active Directory**
- **SAML/OAuth providers**
- **Scalability** (clustering)
- **Premium support**
- **SLA guarantees**

## 📊 **Comparison: Rocket.Chat vs Mattermost**

| **Feature** | **Rocket.Chat (Free)** | **Mattermost (Free)** |
|-------------|------------------------|------------------------|
| **Users** | Unlimited | Unlimited |
| **Video Calls** | ✅ Built-in WebRTC | ❌ Requires plugin |
| **Screen Sharing** | ✅ Yes | ❌ Limited |
| **Apps/Marketplace** | ✅ Rich marketplace | ❌ Basic integrations |
| **Real-time Translation** | ✅ Yes | ❌ No |
| **Omnichannel** | ❌ Enterprise only | ❌ Not available |
| **Setup Complexity** | 🟡 Moderate | 🟢 Easy |

## Data Persistence

All data is stored in Docker volumes:
- Chat messages and files
- User accounts and settings
- Database data
- Configuration files
- File uploads

Data will persist even if you stop and restart the containers.

## 🌐 Production Deployment

For production deployment, use the production Docker Compose file:

```bash
# Copy and edit environment for production
cp .env.example .env.prod
nano .env.prod

# Start with production configuration
docker-compose -f docker-compose.prod.yml --env-file .env.prod up -d
```

### Production Features:
- 🔒 Enhanced security settings
- 🌐 Nginx reverse proxy with SSL support
- 📊 Improved logging and monitoring
- 🛑 Security hardening (no-new-privileges, non-root user)
- 🔐 SSL/TLS ready configuration

## 🔒 Security Notes

### Development (default setup):
- Uses example passwords (change immediately!)
- Intended for local development/testing only
- Less restrictive security settings

### Production recommendations:
- ✅ Change all default passwords
- ✅ Use `docker-compose.prod.yml`
- ✅ Configure SSL/TLS certificates
- ✅ Set up proper authentication
- ✅ Enable 2FA for all users
- ✅ Regular backups (`make backup`)
- ✅ Keep images updated (`make update`)

## 🔧 Advanced Configuration

### Environment Variables
All configuration is done via `.env` file. Key variables:

- `MONGO_ROOT_PASSWORD`: MongoDB password (⚠️ required)
- `ROOT_URL`: Your domain (for production)
- `ROCKETCHAT_PORT`: Port to expose (default: 3000)
- `MONGO_VERSION`: MongoDB version (default: 6.0)
- `ROCKETCHAT_VERSION`: Rocket.Chat version (default: latest)

### Auto-Create Admin User
Add these to your `.env` file for automatic admin creation:
```bash
ADMIN_USERNAME=admin
ADMIN_PASS=your_secure_password
ADMIN_EMAIL=admin@yourdomain.com
```

### File Structure
```
rocketchat-app/
├── .env.example              # Environment template
├── .env                       # Your environment (created by make setup)
├── .gitignore                # Git ignore file
├── docker-compose.yml        # Development configuration
├── docker-compose.prod.yml   # Production configuration
├── Makefile                  # Management commands
├── LICENSE                   # JIN License
└── README.md                 # This file
```

## 🐛 Troubleshooting

### Common Issues:

**Port already in use:**
If you see an error message indicating that port 3000 is already in use, you can change the port on which Rocket.Chat runs.

1.  Open the `.env` file.
2.  Change the `ROCKETCHAT_PORT` variable to a different port, for example:
    ```
    ROCKETCHAT_PORT=3001
    ```
3.  Restart the application: `make restart`

**MongoDB Connection Issues:**
If the Rocket.Chat container has trouble connecting to MongoDB, you can check the replica set status.

```bash
# Check replica set status
make init-replica
```

If the replica set is not initialized, this command will attempt to initialize it.

**Container Startup Problems:**
If containers are not starting correctly, check the logs for errors.

```bash
# Check logs for all services
make logs

# Check logs for a specific service
make logs-app
make logs-db
```

**"Nuclear Option" - Reset Everything:**
If you want to start from a clean slate, you can use the `reset` command. This will remove all data, including messages, users, and settings.

```bash
# ⚠️ This will delete ALL data!
make reset
```

### Vulnerability Scanning:
You can scan the Docker images for known vulnerabilities using the `trivy-scan` command.

```bash
make trivy-scan
```

This will use Trivy to scan the `rocketchat/rocket.chat` and `mongo` images for high and critical severity vulnerabilities.

## 🤝 Contributing

Contributions are welcome! If you'd like to improve this project, please follow these steps:

1.  **Fork the repository.**
2.  **Create a new branch** for your feature or bug fix:
    ```bash
    git checkout -b feature/my-new-feature
    ```
3.  **Make your changes.**
4.  **Commit your changes** with a clear and descriptive commit message:
    ```bash
    git commit -m "feat: Add new feature"
    ```
5.  **Push to your branch:**
    ```bash
    git push origin feature/my-new-feature
    ```
6.  **Create a pull request.**

Please make sure your code adheres to the existing style and conventions.

## 📱 Mobile Apps

Download official Rocket.Chat apps:
- **iOS**: App Store
- **Android**: Google Play Store
- **Desktop**: Available for Windows, macOS, Linux

Configure server URL: `http://localhost:3000` (or your domain)

## 🔌 Integrations

Rocket.Chat supports numerous integrations:
- **Slack** (import/export)
- **GitHub/GitLab**
- **Jira/Trello**
- **Google Drive/OneDrive**
- **Zapier**
- **Custom webhooks & bots**

Access integrations via: **Administration → Integrations**
