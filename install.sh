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

# Color codes - Purple Theme
PURPLE='\033[0;35m'
BOLD_PURPLE='\033[1;35m'
LIGHT_PURPLE='\033[0;95m'
MAGENTA='\033[0;36m'
BOLD_MAGENTA='\033[1;36m'
WHITE='\033[1;37m'
GRAY='\033[0;90m'
DIM='\033[2m'
BOLD='\033[1m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Unicode characters
CHECK='✓'
CROSS='✗'
ARROW='→'
STAR='★'
DOT='•'

# Cleanup function for script interruption
cleanup() {
    if [ -d "$TEMP_DIR" ]; then
        rm -rf "$TEMP_DIR"
    fi
}

trap cleanup EXIT INT TERM

# Print functions with style
print_header() {
    echo ""
    echo -e "${BOLD_PURPLE}╔════════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BOLD_PURPLE}║${NC}                                                                    ${BOLD_PURPLE}║${NC}"
    echo -e "${BOLD_PURPLE}║${NC}     ${LIGHT_PURPLE}${STAR}${NC}  ${BOLD}Claude Config Installer${NC}  ${LIGHT_PURPLE}${STAR}${NC}                           ${BOLD_PURPLE}║${NC}"
    echo -e "${BOLD_PURPLE}║${NC}                                                                    ${BOLD_PURPLE}║${NC}"
    echo -e "${BOLD_PURPLE}║${NC}     ${DIM}Reusable Claude Code configuration template${NC}              ${BOLD_PURPLE}║${NC}"
    echo -e "${BOLD_PURPLE}║${NC}                                                                    ${BOLD_PURPLE}║${NC}"
    echo -e "${BOLD_PURPLE}╚════════════════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

print_info() {
    echo -e "${PURPLE}${ARROW}${NC} ${WHITE}$1${NC}"
}

print_success() {
    echo -e "${GREEN}${CHECK}${NC} ${WHITE}$1${NC}"
}

print_error() {
    echo -e "${RED}${CROSS}${NC} ${WHITE}$1${NC}"
}

print_step() {
    echo -e "${BOLD_MAGENTA}${DOT}${NC} ${BOLD}$1${NC}"
}

print_detail() {
    echo -e "  ${GRAY}$1${NC}"
}

print_section() {
    echo ""
    echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "  ${BOLD_PURPLE}$1${NC}"
    echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
}

print_final_success() {
    echo ""
    echo -e "${GREEN}╔════════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║${NC}                                                                    ${GREEN}║${NC}"
    echo -e "${GREEN}║${NC}     ${BOLD}${CHECK} Installation Complete!${NC}                                     ${GREEN}║${NC}"
    echo -e "${GREEN}║${NC}                                                                    ${GREEN}║${NC}"
    echo -e "${GREEN}╚════════════════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

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
        echo -e "${LIGHT_PURPLE}${message}${NC}"
        print_success "Auto-confirming..."
        return 0
    fi
    
    echo ""
    echo -e "${YELLOW}${message}${NC}"
    echo ""
    echo -ne "${BOLD_PURPLE}Continue? [y/N]:${NC} "
    read -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_error "Installation cancelled by user"
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
    
    print_step "Creating backup..."
    cp -r "$install_path" "$backup_path"
    print_success "Backup created at: ${GRAY}$backup_path${NC}"
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
    
    print_step "Cleaning up old backups (keeping last $MAX_BACKUPS)..."
    
    # Remove oldest backups
    find "$backup_base" -mindepth 1 -maxdepth 1 -type d -printf '%T+ %p\n' | \
        sort | \
        head -n -$MAX_BACKUPS | \
        cut -d' ' -f2- | \
        xargs rm -rf
    
    print_success "Old backups cleaned up"
}

# Show diff between current and new configuration
show_diff() {
    local current_path="$1"
    local new_path="$2"
    
    if [ ! -d "$current_path" ]; then
        print_info "No existing configuration found. Installing fresh copy."
        return 0
    fi
    
    print_step "Comparing configurations..."
    echo ""
    
    local diff_cmd=$(detect_colordiff)
    
    # Show diff
    if $diff_cmd -r "$current_path" "$new_path" 2>/dev/null; then
        print_success "No changes detected. Configuration is already up to date."
        echo ""
        echo -ne "${BOLD_PURPLE}Continue with installation anyway? [y/N]:${NC} "
        read -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_info "Installation cancelled"
            exit 0
        fi
    else
        echo ""
        echo -e "${YELLOW}${DOT} Changes detected between current and new configuration${NC}"
        if [ "$diff_cmd" = "diff" ]; then
            print_detail "Tip: Install 'colordiff' for better diff visualization"
        fi
        echo ""
    fi
}

# Clone repository
clone_repo() {
    print_step "Downloading from GitHub..."
    
    # Check if git is installed
    if ! command -v git &> /dev/null; then
        print_error "git is not installed. Please install git and try again."
        exit 1
    fi
    
    # Clone repository
    if git clone --depth 1 --branch "$VERSION" "$REPO_URL" "$TEMP_DIR" &> /dev/null; then
        print_success "Repository downloaded successfully"
    else
        print_error "Failed to clone repository"
        print_detail "Please check your internet connection and verify version '$VERSION' exists"
        exit 1
    fi
}

# Install configuration
install_config() {
    local install_path="$1"
    local source_path="$TEMP_DIR/.claude"
    
    # Verify source exists
    if [ ! -d "$source_path" ]; then
        print_error "Source configuration not found in repository"
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
    print_step "Installing configuration..."
    cp -r "$source_path" "$install_path"
    print_success "Configuration installed to: ${GRAY}$install_path${NC}"
}

# Show success message
show_success_message() {
    local install_path="$1"
    
    print_final_success
    
    print_info "Installation location: ${GRAY}$install_path${NC}"
    echo ""
    
    echo -e "${BOLD}What's included:${NC}"
    echo -e "  ${PURPLE}${DOT}${NC} Global settings ${GRAY}(CLAUDE.md)${NC}"
    echo -e "  ${PURPLE}${DOT}${NC} 6 custom commands"
    echo -e "  ${PURPLE}${DOT}${NC} 5 skill modules"
    echo ""
    
    if [ "$INSTALL_LOCATION" = "global" ]; then
        echo -e "${BOLD}Next steps:${NC}"
        echo -e "  ${LIGHT_PURPLE}1.${NC} This global configuration will apply to all projects"
        echo -e "  ${LIGHT_PURPLE}2.${NC} Restart Claude Code to apply changes"
    else
        echo -e "${BOLD}Next steps:${NC}"
        echo -e "  ${LIGHT_PURPLE}1.${NC} Commit the .claude/ directory to version control"
        echo -e "  ${LIGHT_PURPLE}2.${NC} Restart Claude Code to apply changes"
    fi
    
    echo ""
    echo -e "${DIM}Learn more: ${PURPLE}https://github.com/whyleonardo/claude-config${NC}"
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
    print_header
    
    print_section "Configuration"
    print_detail "Mode:    ${BOLD}$INSTALL_LOCATION${NC}"
    print_detail "Version: ${BOLD}$VERSION${NC}"
    print_detail "Target:  ${BOLD}$install_path${NC}"
    
    # Check if directory exists and ask for confirmation
    print_section "Confirmation"
    if [ ! -d "$install_path" ]; then
        if [ "$INSTALL_LOCATION" = "global" ]; then
            confirm_action "Installing to global location: ${BOLD}$install_path${NC}
${GRAY}This will affect all projects using Claude Code.${NC}"
        else
            confirm_action "Creating new directory: ${BOLD}$install_path${NC}
${GRAY}This will add Claude Code configuration to your project.${NC}"
        fi
    elif [ "$UPDATE_MODE" = true ]; then
        confirm_action "Existing configuration found at: ${BOLD}$install_path${NC}
${GRAY}A backup will be created at: $backup_base/<timestamp>/${NC}"
    else
        confirm_action "Existing configuration found at: ${BOLD}$install_path${NC}
${GRAY}This will overwrite your current configuration.${NC}
${GRAY}A backup will be created at: $backup_base/<timestamp>/${NC}"
    fi
    
    # Clone repository
    print_section "Download"
    clone_repo
    
    # Show diff if updating
    if [ "$UPDATE_MODE" = true ] || [ -d "$install_path" ]; then
        echo ""
        show_diff "$install_path" "$TEMP_DIR/.claude"
    fi
    
    # Backup existing configuration
    if [ -d "$install_path" ]; then
        print_section "Backup"
        backup_existing "$install_path" "$backup_base"
        cleanup_old_backups "$backup_base"
    fi
    
    # Install configuration
    print_section "Installation"
    install_config "$install_path"
    
    # Show success message
    show_success_message "$install_path"
}

# Run main function
main "$@"
