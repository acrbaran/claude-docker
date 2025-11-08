# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Dockerized Claude Code environment with SuperClaude framework integration. The project creates a containerized development environment with automatic update management and Turkish localization.

## Architecture

### Container Structure
- **Base Image**: Ubuntu 22.04 with Node.js 22.x, Python 3, and Git
- **Core Integration**: Claude Code CLI with SuperClaude framework
- **Update System**: Automatic version checking with optional updates
- **Localization**: Turkish interface and messaging

### Key Components
- **Dockerfile**: Multi-stage build installing Claude Code, SuperClaude, and dependencies
- **docker-compose.yml**: Service configuration with volume mounting and environment variables
- **Update Scripts**: Automated version management (`check_update.sh`, `update_now.sh`)
- **Startup Integration**: Automatic update checking on container start

## Common Commands

### Development Environment
```bash
# Build and start the container
docker-compose up -d --build

# Access the running container
docker-compose exec claude bash

# View container logs
docker-compose logs -f claude

# Stop the container
docker-compose down
```

### Update Management
```bash
# Manual update check (inside container)
/usr/local/bin/check_update.sh

# Force update (inside container)
/usr/local/bin/update_now.sh

# Skip update check and start Claude directly
docker-compose exec claude bash -c "claude"
```

### SuperClaude Framework
```bash
# Access SuperClaude commands (inside container)
sc help
sc install --force --yes
sc update
```

## Environment Configuration

### Required Environment Variables (.env file)
- `ANTHROPIC_BASE_URL`: Custom API endpoint
- `ANTHROPIC_AUTH_TOKEN`: Authentication token
- `CLAUDE_CODE_SKIP_AUTH_LOGIN=1`: Skip authentication flow
- `LOCAL_PATH`: Host system path for volume mounting

### Container Environment
- `CLAUDE_HOME=/root/.claude`: Claude configuration directory
- `CLAUDE_DISABLE_PLUGINS=true`: Plugin management
- `SUPERCLAUDE_PATH=/opt/SuperClaude_Framework`: Framework path
- Working directory: `/workspace`

## Volume Mounting Strategy

The project uses strategic volume mounting for persistence and isolation:
- **Main workspace**: `${LOCAL_PATH}:/workspace` - Mounts host directory as workspace
- **Claude isolation**: `${LOCAL_PATH}/empty:/workspace/.claude` - Isolates Claude configuration

## Update System Architecture

### Automatic Update Flow
1. Container start triggers `check_update.sh` via `.bashrc`
2. Script compares installed vs latest SuperClaude version
3. Interactive prompt for update decisions (unless in auto-start mode)
4. Optional update execution via `update_now.sh`
5. Automatic Claude Code startup after update process

### Version Management
- Uses `pip index versions` for latest version detection
- Semantic version comparison with `sort -V`
- Colored output and Turkish localization
- Logging support for troubleshooting

## Development Notes

### Container Access Patterns
- The container runs with `stdin_open: true` and `tty: true` for interactive sessions
- Default command launches bash shell with Claude Code available
- SuperClaude aliased as `sc` for quick access

### Security Considerations
- Authentication tokens stored in environment variables
- Claude configuration isolated in separate volume mount
- Non-interactive installation with expect scripts for initial setup

### Localization
All user-facing messages use Turkish language with color coding:
- 🟡 Yellow for warnings and prompts
- 🔵 Blue for informational messages
- 🟢 Green for success states
- 🔴 Red for errors and critical notices