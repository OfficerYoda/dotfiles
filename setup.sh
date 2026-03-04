#!/bin/bash

# Dotfiles VPS Setup Script
# This script automates the complete setup of dotfiles on a fresh Ubuntu/Debian VPS
#
# run it with:
# curl -fsSL https://raw.githubusercontent.com/OfficerYoda/dotfiles/main/setup.sh | bash

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running on Ubuntu/Debian
if ! command -v apt &> /dev/null; then
    log_error "This script is designed for Ubuntu/Debian systems with apt package manager"
    exit 1
fi

log_info "Starting VPS dotfiles setup..."
echo ""

# ============================================================================
# 1. System Update & Basic Dependencies
# ============================================================================
log_info "Step 1/18: Updating system and installing basic dependencies..."
sudo apt update
sudo apt upgrade -y
sudo apt install -y curl wget git build-essential unzip ca-certificates
log_success "System updated and basic dependencies installed"
echo ""

# ============================================================================
# 2. Install Core CLI Tools
# ============================================================================
log_info "Step 2/18: Installing core CLI tools from apt..."
sudo apt install -y \
  fish \
  tmux \
  neovim \
  fzf \
  ripgrep \
  fd-find \
  btop \
  python3 \
  python3-pip \
  python3-venv \
  pipx \
  jq
log_success "Core CLI tools installed"
echo ""

# ============================================================================
# 3. Install Starship Prompt
# ============================================================================
log_info "Step 3/18: Installing Starship prompt..."
if ! command -v starship &> /dev/null; then
    curl -sS https://starship.rs/install.sh | sh -s -- -y
    log_success "Starship installed"
else
    log_warning "Starship already installed, skipping"
fi
echo ""

# ============================================================================
# 4. Install Zoxide
# ============================================================================
log_info "Step 4/18: Installing Zoxide..."
if ! command -v zoxide &> /dev/null; then
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
    log_success "Zoxide installed"
else
    log_warning "Zoxide already installed, skipping"
fi
echo ""

# ============================================================================
# 5. Install Bat
# ============================================================================
log_info "Step 5/18: Installing bat..."
sudo apt install -y bat

# Create symlink if installed as 'batcat'
if command -v batcat &> /dev/null && ! command -v bat &> /dev/null; then
    mkdir -p ~/.local/bin
    ln -s /usr/bin/batcat ~/.local/bin/bat
    log_success "Bat installed and symlinked"
else
    log_success "Bat installed"
fi
echo ""

# ============================================================================
# 6. Install Mise
# ============================================================================
log_info "Step 6/18: Installing Mise..."
if ! command -v mise &> /dev/null; then
    curl https://mise.run | sh
    export PATH="$HOME/.local/bin:$PATH"
    log_success "Mise installed"
else
    log_warning "Mise already installed, skipping"
fi
echo ""

# ============================================================================
# 7. Install Rust
# ============================================================================
log_info "Step 7/18: Installing Rust toolchain..."
if ! command -v cargo &> /dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
    log_success "Rust installed"
else
    log_warning "Rust already installed, skipping"
    source "$HOME/.cargo/env" 2>/dev/null || true
fi
echo ""

# ============================================================================
# 8. Install Yazi
# ============================================================================
log_info "Step 8/18: Installing Yazi file manager..."
if ! command -v yazi &> /dev/null; then
    cargo install --locked yazi-fm yazi-cli
    log_success "Yazi installed"
else
    log_warning "Yazi already installed, skipping"
fi
echo ""

# ============================================================================
# 9. Install Bun
# ============================================================================
log_info "Step 9/18: Installing Bun..."
if ! command -v bun &> /dev/null; then
    curl -fsSL https://bun.sh/install | bash
    export BUN_INSTALL="$HOME/.bun"
    export PATH="$BUN_INSTALL/bin:$PATH"
    log_success "Bun installed"
else
    log_warning "Bun already installed, skipping"
fi
echo ""

# ============================================================================
# 10. Install Optional/Fun Tools
# ============================================================================
log_info "Step 10/18: Installing optional tools (pigz, chafa, asciiquarium, lazydocker, lazygit)..."

# Pigz
sudo apt install -y pigz

# Chafa
sudo apt install -y chafa

# Asciiquarium
log_info "Installing asciiquarium..."
sudo apt install -y libcurses-perl libterm-animation-perl
cd /tmp
wget -q http://www.robobunny.com/projects/asciiquarium/asciiquarium.tar.gz
tar -zxf asciiquarium.tar.gz
cd asciiquarium_* 2>/dev/null || cd asciiquarium
sudo cp asciiquarium /usr/local/bin/
sudo chmod +x /usr/local/bin/asciiquarium
cd ~

# LazyDocker
log_info "Installing lazydocker..."
if ! command -v lazydocker &> /dev/null; then
    LAZYDOCKER_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazydocker/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -sLo lazydocker.tar.gz "https://github.com/jesseduffield/lazydocker/releases/latest/download/lazydocker_${LAZYDOCKER_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazydocker.tar.gz lazydocker
    sudo install lazydocker /usr/local/bin
    rm lazydocker.tar.gz lazydocker
    log_success "LazyDocker installed"
else
    log_warning "LazyDocker already installed, skipping"
fi

# LazyGit
log_info "Installing lazygit..."
if ! command -v lazygit &> /dev/null; then
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -sLo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit /usr/local/bin
    rm lazygit.tar.gz lazygit
    log_success "LazyGit installed"
else
    log_warning "LazyGit already installed, skipping"
fi

log_success "Optional tools installed"
echo ""

# ============================================================================
# 11. Clone Dotfiles Repository
# ============================================================================
log_info "Step 11/18: Cloning dotfiles repository..."

# Backup existing .config if it exists
if [ -d "$HOME/.config" ] && [ ! -d "$HOME/.config/.git" ]; then
    log_warning "Backing up existing .config to .config.backup"
    mv "$HOME/.config" "$HOME/.config.backup.$(date +%Y%m%d_%H%M%S)"
fi

# Clone or update dotfiles
if [ ! -d "$HOME/.config/.git" ]; then
    git clone https://github.com/OfficerYoda/dotfiles.git "$HOME/.config"
    log_success "Dotfiles cloned to ~/.config"
else
    log_warning "Dotfiles already cloned, pulling latest changes"
    cd "$HOME/.config"
    git pull
fi
echo ""

# ============================================================================
# 12. Install Tmux Plugin Manager (TPM)
# ============================================================================
log_info "Step 12/18: Installing Tmux Plugin Manager..."
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
    log_success "TPM installed"
else
    log_warning "TPM already installed, skipping"
fi
echo ""

# ============================================================================
# 13. Install Tmux Plugins
# ============================================================================
log_info "Step 13/18: Installing Tmux plugins..."
if [ -d "$HOME/.tmux/plugins/tpm" ]; then
    "$HOME/.tmux/plugins/tpm/bin/install_plugins"
    log_success "Tmux plugins installed"
fi
echo ""

# ============================================================================
# 14. Install Yazi Plugins
# ============================================================================
log_info "Step 14/18: Installing Yazi plugins..."
if command -v ya &> /dev/null; then
    ya pack -i
    log_success "Yazi plugins installed"
else
    log_warning "Yazi CLI (ya) not found, skipping plugin installation"
fi
echo ""

# ============================================================================
# 15. Setup Fish Shell
# ============================================================================
log_info "Step 15/18: Setting up Fish shell..."

# Add fish to valid shells
FISH_PATH=$(which fish)
if ! grep -q "$FISH_PATH" /etc/shells; then
    echo "$FISH_PATH" | sudo tee -a /etc/shells
    log_success "Fish added to /etc/shells"
fi

# Change default shell
if [ "$SHELL" != "$FISH_PATH" ]; then
    log_info "Changing default shell to Fish (requires password)..."
    chsh -s "$FISH_PATH"
    log_success "Default shell changed to Fish"
else
    log_warning "Fish is already the default shell"
fi
echo ""

# ============================================================================
# 16. Initialize Fish Configuration
# ============================================================================
log_info "Step 16/18: Initializing Fish configuration..."
# Fish will load config automatically on first run
fish -c "echo 'Fish configuration loaded successfully'" 2>/dev/null || true
log_success "Fish configuration initialized"
echo ""

# ============================================================================
# 17. Setup Neovim
# ============================================================================
log_info "Step 17/18: Setting up Neovim..."
log_info "Neovim plugins will be installed automatically on first run"
log_info "You can verify by running: nvim and checking plugin installation"
log_success "Neovim configuration ready"
echo ""

# ============================================================================
# 18. Final Steps
# ============================================================================
log_info "Step 18/18: Finalizing setup..."

# Ensure ~/.local/bin is in PATH
mkdir -p "$HOME/.local/bin"

log_success "Setup complete!"
echo ""

# ============================================================================
# Summary
# ============================================================================
echo -e "${GREEN}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║                    SETUP COMPLETED!                        ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo "Next steps:"
echo "  1. Log out and log back in for shell changes to take effect"
echo "  2. Fish will be your default shell"
echo "  3. Tmux will auto-start with the 'home' session"
echo "  4. First run of 'nvim' will install all LazyVim plugins"
echo ""
echo "Installed tools:"
echo "  • Core: fish, tmux, neovim, git, fzf, ripgrep, fd, btop"
echo "  • Shell: starship, zoxide, bat, mise"
echo "  • File management: yazi"
echo "  • Development: rust, bun, lazygit, lazydocker"
echo "  • Fun: asciiquarium, chafa, pigz"
echo ""
echo "Useful commands:"
echo "  • 'n' or 'nvim' - Open Neovim"
echo "  • 'y' - Open Yazi file manager"
echo "  • 'lazygit' or 'lg' - Git TUI"
echo "  • 'lazydocker' - Docker TUI"
echo "  • 'btop' - System monitor"
echo ""
echo "Tmux key bindings (prefix: Ctrl+p):"
echo "  • Ctrl+p then f - Fuzzy find projects"
echo "  • Ctrl+p then g - Switch sessions"
echo "  • Ctrl+p then b - Open btop"
echo "  • Ctrl+p then v - Open lazydocker"
echo "  • Ctrl+p then t - Open asciiquarium"
echo ""
log_warning "Please log out and log back in for all changes to take effect!"
echo ""
