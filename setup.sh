#!/bin/bash

# Postman Training Framework - Setup Script
# This script installs all necessary dependencies for running the Postman training framework

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
print_header() {
    echo -e "\n${BLUE}===================================================${NC}"
    echo -e "${BLUE}  $1${NC}"
    echo -e "${BLUE}===================================================${NC}\n"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_info() {
    echo -e "${YELLOW}ℹ $1${NC}"
}

print_step() {
    echo -e "${BLUE}→ $1${NC}"
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Detect OS
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "linux"
    elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
        echo "windows"
    else
        echo "unknown"
    fi
}

# Main setup
print_header "Postman Training Framework Setup"

OS=$(detect_os)
print_info "Detected OS: $OS"

# Check Node.js
print_step "Checking Node.js installation..."
if command_exists node; then
    NODE_VERSION=$(node --version)
    print_success "Node.js is installed: $NODE_VERSION"
else
    print_error "Node.js is not installed"
    print_info "Please install Node.js from: https://nodejs.org/"

    if [[ "$OS" == "macos" ]]; then
        print_info "On macOS, you can install with Homebrew:"
        echo "  brew install node"
    elif [[ "$OS" == "linux" ]]; then
        print_info "On Linux, you can install with:"
        echo "  sudo apt-get install nodejs npm  # Ubuntu/Debian"
        echo "  sudo yum install nodejs npm      # CentOS/RHEL"
    fi

    exit 1
fi

# Check npm
print_step "Checking npm installation..."
if command_exists npm; then
    NPM_VERSION=$(npm --version)
    print_success "npm is installed: $NPM_VERSION"
else
    print_error "npm is not installed"
    print_info "npm usually comes with Node.js. Please reinstall Node.js."
    exit 1
fi

# Install Newman
print_step "Checking Newman (Postman CLI) installation..."
if command_exists newman; then
    NEWMAN_VERSION=$(newman --version)
    print_success "Newman is already installed: $NEWMAN_VERSION"
else
    print_info "Newman is not installed. Installing now..."

    if npm install -g newman; then
        print_success "Newman installed successfully"
        NEWMAN_VERSION=$(newman --version)
        print_info "Newman version: $NEWMAN_VERSION"
    else
        print_error "Failed to install Newman"
        print_info "Try running with sudo: sudo npm install -g newman"
        exit 1
    fi
fi

# Install Newman HTML Reporter (optional but useful)
print_step "Checking Newman HTML Reporter..."
if npm list -g newman-reporter-html >/dev/null 2>&1; then
    print_success "Newman HTML Reporter is already installed"
else
    print_info "Installing Newman HTML Reporter for better test reports..."

    if npm install -g newman-reporter-html; then
        print_success "Newman HTML Reporter installed successfully"
    else
        print_error "Failed to install Newman HTML Reporter (optional)"
        print_info "You can continue without it, or try: sudo npm install -g newman-reporter-html"
    fi
fi

# Check Postman Desktop App
print_step "Checking Postman Desktop App..."
if [[ "$OS" == "macos" ]]; then
    if [ -d "/Applications/Postman.app" ]; then
        print_success "Postman Desktop App is installed"
    else
        print_info "Postman Desktop App not found"
        print_info "You can install it from: https://www.postman.com/downloads/"

        if command_exists brew; then
            print_info "Or install with Homebrew:"
            echo "  brew install --cask postman"
            echo ""
            read -p "Would you like to install Postman with Homebrew now? (y/n) " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                print_step "Installing Postman..."
                if brew install --cask postman; then
                    print_success "Postman installed successfully"
                else
                    print_error "Failed to install Postman"
                fi
            fi
        fi
    fi
elif [[ "$OS" == "linux" ]]; then
    if command_exists postman; then
        print_success "Postman is installed"
    else
        print_info "Postman Desktop App not found"
        print_info "Download from: https://www.postman.com/downloads/"
        print_info "Or install via Snap: sudo snap install postman"
    fi
fi

# Validate JSON files
print_step "Validating collection and environment files..."

if [ -f "collections/01-basics/rest-api-basics.json" ]; then
    if python3 -m json.tool collections/01-basics/rest-api-basics.json > /dev/null 2>&1; then
        print_success "Collection file is valid JSON"
    else
        print_error "Collection file has invalid JSON syntax"
        exit 1
    fi
else
    print_error "Collection file not found: collections/01-basics/rest-api-basics.json"
    exit 1
fi

if [ -f "environments/training-local.json" ]; then
    if python3 -m json.tool environments/training-local.json > /dev/null 2>&1; then
        print_success "Environment file is valid JSON"
    else
        print_error "Environment file has invalid JSON syntax"
        exit 1
    fi
else
    print_error "Environment file not found: environments/training-local.json"
    exit 1
fi

# Run a test to verify everything works
print_step "Running a quick test to verify setup..."
if newman run collections/01-basics/rest-api-basics.json \
    --environment environments/training-local.json \
    --reporters cli \
    --bail > /dev/null 2>&1; then
    print_success "Test run successful! All systems operational."
else
    print_error "Test run failed. Please check your internet connection."
    print_info "JSONPlaceholder API (https://jsonplaceholder.typicode.com) must be accessible."
fi

# Summary
print_header "Setup Complete!"

echo -e "${GREEN}✓ All dependencies are installed and configured${NC}\n"

echo -e "${BLUE}Installed Components:${NC}"
echo -e "  • Node.js: ${NODE_VERSION}"
echo -e "  • npm: ${NPM_VERSION}"
echo -e "  • Newman: $(newman --version 2>/dev/null || echo 'Not available')"

if [[ "$OS" == "macos" ]] && [ -d "/Applications/Postman.app" ]; then
    echo -e "  • Postman Desktop App: ✓"
fi

echo -e "\n${BLUE}Next Steps:${NC}"
echo -e "  1. Import the collection in Postman:"
echo -e "     ${YELLOW}collections/01-basics/rest-api-basics.json${NC}"
echo -e ""
echo -e "  2. Import the environment in Postman:"
echo -e "     ${YELLOW}environments/training-local.json${NC}"
echo -e ""
echo -e "  3. Run tests from command line:"
echo -e "     ${YELLOW}newman run collections/01-basics/rest-api-basics.json --environment environments/training-local.json${NC}"
echo -e ""
echo -e "  4. View test results dashboard:"
echo -e "     ${YELLOW}open test-results.html${NC}"
echo -e ""
echo -e "  5. Start learning:"
echo -e "     ${YELLOW}Read guides/01-getting-started.md${NC}"
echo -e ""

print_success "Happy Testing! 🧪✨"
