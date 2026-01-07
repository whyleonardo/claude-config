#!/bin/bash
set -e

# Claude Config Installer
# Installs Claude Code configuration to local or global directory
# Repository: https://github.com/whyleonardo/claude-config

# Configuration
REPO_URL="https://github.com/whyleonardo/claude-config.git"
REPO_NAME="claude-config"
VERSION="main"
INSTALL_LOCATION="local"
UPDATE_MODE=false
SKIP_CONFIRM=false
MAX_BACKUPS=3
BACKUP_DIR=".claude-backups"
TEMP_DIR="/tmp/claude-config-$$"

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Cleanup function for script interruption
cleanup() {
    if [ -d "$TEMP_DIR" ]; then
        rm -rf "$TEMP_DIR"
    fi
}

trap cleanup EXIT INT TERM

# Show help message
show_help() {
    cat << EOF
Claude Config Installer

Usage: $0 [OPTIONS]

OPTIONS:
    -l, --local         Install to current directory's .claude/ (default)
    -g, --global        Install to ~/.claude/ for global configuration
    -u, --update        Update existing installation
    -v, --version TAG   Install specific version (default: main)
    -y, --yes           Skip confirmation prompts (auto-confirm)
    -h, --help          Show this help message

EXAMPLES:
    # Install locally (project-specific)
    $0 --local

    # Install globally (all projects)
    $0 --global

    # Update existing installation
    $0 --update

    # Install specific version
    $0 --version v1.0.0

    # Update global installation
    $0 --global --update

For more information, visit: https://github.com/whyleonardo/claude-config
EOF
}

# Parse command line arguments
parse_arguments() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            -l|--local)
                INSTALL_LOCATION="local"
                shift
                ;;
            -g|--global)
                INSTALL_LOCATION="global"
                shift
                ;;
            -u|--update)
                UPDATE_MODE=true
                shift
                ;;
            -y|--yes)
                SKIP_CONFIRM=true
                shift
                ;;
            -v|--version)
                VERSION="$2"
                shift 2
                ;;
            -h|--help)
                show_help
                exit 0
                ;;
            *)
                echo -e "${RED}Error: Unknown option: $1${NC}"
                show_help
                exit 1
                ;;
        esac
    done
}

# Detect if colordiff is available
detect_colordiff() {
    if command -v colordiff &> /dev/null; then
        echo "colordiff"
    else
        echo "diff"
    fi
}

# Get the installation path based on location
get_install_path() {
    if [ "$INSTALL_LOCATION" = "global" ]; then
        echo "$HOME/.claude"
    else
        echo "$(pwd)/.claude"
    fi
}

# Get the backup directory path
get_backup_path() {
    local install_path="$1"
    local parent_dir=$(dirname "$install_path")
    echo "$parent_dir/$BACKUP_DIR"
}

# Confirm action with user
confirm_action() {
    local message="$1"
    
    # Skip confirmation if --yes flag is set or if stdin is not a terminal (piped input)
    if [ "$SKIP_CONFIRM" = true ] || [ ! -t 0 ]; then
        echo -e "${BLUE}$message${NC}"
        echo -e "${GREEN}Auto-confirming...${NC}"
        return 0
    fi
    
    echo -e "${YELLOW}$message${NC}"
    read -p "Continue? [y/N]: " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${RED}Installation cancelled.${NC}"
        exit 0
    fi
}

# Backup existing configuration
backup_existing() {
    local install_path="$1"
    local backup_base="$2"
    
    if [ ! -d "$install_path" ]; then
        return 0
    fi
    
    # Create backup directory if it doesn't exist
    mkdir -p "$backup_base"
    
    # Create timestamped backup
    local timestamp=$(date +%Y-%m-%d-%H%M%S)
    local backup_path="$backup_base/$timestamp"
    
    echo -e "${BLUE}Creating backup...${NC}"
    cp -r "$install_path" "$backup_path"
    echo -e "${GREEN}✓ Backup created: $backup_path${NC}"
}

# Cleanup old backups (keep only last MAX_BACKUPS)
cleanup_old_backups() {
    local backup_base="$1"
    
    if [ ! -d "$backup_base" ]; then
        return 0
    fi
    
    # Count backups
    local backup_count=$(find "$backup_base" -mindepth 1 -maxdepth 1 -type d | wc -l)
    
    if [ "$backup_count" -le "$MAX_BACKUPS" ]; then
        return 0
    fi
    
    echo -e "${BLUE}Cleaning up old backups (keeping last $MAX_BACKUPS)...${NC}"
    
    # Remove oldest backups
    find "$backup_base" -mindepth 1 -maxdepth 1 -type d -printf '%T+ %p\n' | \
        sort | \
        head -n -$MAX_BACKUPS | \
        cut -d' ' -f2- | \
        xargs rm -rf
    
    echo -e "${GREEN}✓ Old backups cleaned up${NC}"
}

# Show diff between current and new configuration
show_diff() {
    local current_path="$1"
    local new_path="$2"
    
    if [ ! -d "$current_path" ]; then
        echo -e "${BLUE}No existing configuration found. Installing fresh copy.${NC}"
        return 0
    fi
    
    echo -e "${BLUE}Comparing current configuration with new version...${NC}"
    echo ""
    
    local diff_cmd=$(detect_colordiff)
    
    # Show diff
    if $diff_cmd -r "$current_path" "$new_path" 2>/dev/null; then
        echo -e "${GREEN}✓ No changes detected. Configuration is already up to date.${NC}"
        read -p "Continue with installation anyway? [y/N]: " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo -e "${YELLOW}Installation cancelled.${NC}"
            exit 0
        fi
    else
        echo ""
        echo -e "${YELLOW}Changes detected between current and new configuration.${NC}"
        if [ "$diff_cmd" = "diff" ]; then
            echo -e "${CYAN}Tip: Install 'colordiff' for better diff visualization${NC}"
        fi
        echo ""
    fi
}

# Clone repository
clone_repo() {
    echo -e "${BLUE}Downloading Claude Config from GitHub...${NC}"
    
    # Check if git is installed
    if ! command -v git &> /dev/null; then
        echo -e "${RED}Error: git is not installed. Please install git and try again.${NC}"
        exit 1
    fi
    
    # Clone repository
    if git clone --depth 1 --branch "$VERSION" "$REPO_URL" "$TEMP_DIR" &> /dev/null; then
        echo -e "${GREEN}✓ Repository cloned successfully${NC}"
    else
        echo -e "${RED}Error: Failed to clone repository.${NC}"
        echo -e "${YELLOW}Please check your internet connection and verify the version '$VERSION' exists.${NC}"
        exit 1
    fi
}

# Install configuration
install_config() {
    local install_path="$1"
    local source_path="$TEMP_DIR/.claude"
    
    # Verify source exists
    if [ ! -d "$source_path" ]; then
        echo -e "${RED}Error: Source configuration not found in repository.${NC}"
        exit 1
    fi
    
    # Create parent directory if needed
    local parent_dir=$(dirname "$install_path")
    if [ ! -d "$parent_dir" ]; then
        mkdir -p "$parent_dir"
    fi
    
    # Remove existing installation if present
    if [ -d "$install_path" ]; then
        rm -rf "$install_path"
    fi
    
    # Copy configuration
    echo -e "${BLUE}Installing configuration...${NC}"
    cp -r "$source_path" "$install_path"
    echo -e "${GREEN}✓ Configuration installed to: $install_path${NC}"
}

# Show success message
show_success_message() {
    local install_path="$1"
    
    echo ""
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}✓ Claude Config installed successfully!${NC}"
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo -e "${CYAN}Installation location:${NC} $install_path"
    echo ""
    echo -e "${CYAN}What's included:${NC}"
    echo -e "  • Global settings (CLAUDE.md)"
    echo -e "  • 6 custom commands"
    echo -e "  • 5 skill modules"
    echo ""
    
    if [ "$INSTALL_LOCATION" = "global" ]; then
        echo -e "${CYAN}Next steps:${NC}"
        echo -e "  • This global configuration will apply to all projects"
        echo -e "  • Restart Claude Code to apply changes"
    else
        echo -e "${CYAN}Next steps:${NC}"
        echo -e "  • Commit the .claude/ directory to version control"
        echo -e "  • Restart Claude Code to apply changes"
    fi
    
    echo ""
    echo -e "${CYAN}Learn more:${NC} https://github.com/whyleonardo/claude-config"
    echo ""
}

# Main function
main() {
    # Parse arguments
    parse_arguments "$@"
    
    # Get installation path
    local install_path=$(get_install_path)
    local backup_base=$(get_backup_path "$install_path")
    
    # Show header
    echo ""
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${CYAN}   Claude Config Installer${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo -e "${CYAN}Mode:${NC} $INSTALL_LOCATION"
    echo -e "${CYAN}Version:${NC} $VERSION"
    echo -e "${CYAN}Target:${NC} $install_path"
    echo ""
    
    # Check if directory exists and ask for confirmation
    if [ ! -d "$install_path" ]; then
        if [ "$INSTALL_LOCATION" = "global" ]; then
            confirm_action "Installing to global location: $install_path
This will affect all projects using Claude Code."
        else
            confirm_action "Creating new directory: $install_path
This will add Claude Code configuration to your project."
        fi
    elif [ "$UPDATE_MODE" = true ]; then
        confirm_action "Existing configuration found at: $install_path
A backup will be created at: $backup_base/<timestamp>/"
    else
        confirm_action "Existing configuration found at: $install_path
This will overwrite your current configuration.
A backup will be created at: $backup_base/<timestamp>/"
    fi
    
    # Clone repository
    clone_repo
    
    # Show diff if updating
    if [ "$UPDATE_MODE" = true ] || [ -d "$install_path" ]; then
        show_diff "$install_path" "$TEMP_DIR/.claude"
    fi
    
    # Backup existing configuration
    if [ -d "$install_path" ]; then
        backup_existing "$install_path" "$backup_base"
        cleanup_old_backups "$backup_base"
    fi
    
    # Install configuration
    install_config "$install_path"
    
    # Show success message
    show_success_message "$install_path"
}

# Run main function
main "$@"
