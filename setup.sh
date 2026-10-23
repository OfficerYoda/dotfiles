#!/bin/bash

# Dotfiles VPS Setup Script
# This script automates the complete setup of dotfiles on a fresh Ubuntu/Debian VPS
#
# run it with:
# curl -fsSL https://raw.githubusercontent.com/OfficerYoda/dotfiles/main/setup.sh | bash

set -e # Exit on any error

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

# make silent deaths loud: a failing command substitution under `set -e` kills the
# script with no output otherwise (e.g. `X=$(cmd | grep ...)` when grep matches nothing)
trap 'log_error "Failed at line $LINENO: $BASH_COMMAND"' ERR

# Check if running on Ubuntu/Debian
if ! command -v apt &>/dev/null; then
  log_error "This script is designed for Ubuntu/Debian systems with apt package manager"
  exit 1
fi

# Architecture detection (x86_64 and ARM VPS both supported)
case "$(uname -m)" in
x86_64)
  YAZI_ARCH="x86_64-unknown-linux-gnu"
  GH_ARCH="x86_64"
  NVIM_ARCH="x86_64"
  ;;
aarch64 | arm64)
  YAZI_ARCH="aarch64-unknown-linux-gnu"
  GH_ARCH="arm64"
  NVIM_ARCH="arm64"
  ;;
*)
  log_error "Unsupported architecture: $(uname -m)"
  exit 1
  ;;
esac

export PATH="$HOME/.bun/bin:$HOME/.local/bin:$PATH"

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
# 2. Clone Dotfiles Repository (first thing after git exists, so the
#    dotfiles land even if a later install step fails)
# ============================================================================
log_info "Step 2/18: Cloning dotfiles repository..."
if [ -d "$HOME/.config/.git" ]; then
  log_warning "Dotfiles already cloned, pulling latest changes"
  git -C "$HOME/.config" pull --ff-only || log_warning "Could not pull (local changes?), keeping existing clone"
  log_success "Dotfiles up to date in ~/.config"
else
  if [ -d "$HOME/.config" ]; then
    BACKUP="$HOME/.config.backup.$(date +%Y%m%d_%H%M%S)"
    mv "$HOME/.config" "$BACKUP"
    log_warning "Existing ~/.config backed up to $(basename "$BACKUP")"
  fi
  git clone https://github.com/OfficerYoda/dotfiles.git "$HOME/.config"
  log_success "Dotfiles cloned to ~/.config"
fi
echo ""

# ============================================================================
# 3. Install Core CLI Tools
# ============================================================================
log_info "Step 3/18: Installing core CLI tools from apt..."
sudo apt install -y \
  fish \
  tmux \
  fzf \
  ripgrep \
  fd-find \
  btop \
  python3 \
  python3-pip \
  python3-venv \
  pipx \
  jq
# Note: neovim is installed from a GitHub release in step 17 because apt's
# version is too old for LazyVim
log_success "Core CLI tools installed"
echo ""

# ============================================================================
# 4. Install Starship Prompt
# ============================================================================
log_info "Step 4/18: Installing Starship prompt..."
if ! command -v starship &>/dev/null; then
  curl -fsSL https://starship.rs/install.sh | sh -s -- -y
  log_success "Starship installed"
else
  log_warning "Starship already installed, skipping"
fi
echo ""

# ============================================================================
# 5. Install Zoxide
# ============================================================================
log_info "Step 5/18: Installing Zoxide..."
if ! command -v zoxide &>/dev/null; then
  curl -fsSL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
  log_success "Zoxide installed"
else
  log_warning "Zoxide already installed, skipping"
fi
echo ""

# ============================================================================
# 6. Install Bat and Eza
# ============================================================================
log_info "Step 6/18: Installing bat and eza..."
sudo apt install -y bat

# Create symlink if installed as 'batcat'
if command -v batcat &>/dev/null && ! command -v bat &>/dev/null; then
  mkdir -p ~/.local/bin
  ln -sfn /usr/bin/batcat ~/.local/bin/bat
  log_success "Bat installed and symlinked"
else
  log_success "Bat installed"
fi

# Eza (fish's `ls` alias calls it; Ubuntu only ships it from 24.04 on, so use the
# GitHub release — its arch triple is exactly YAZI_ARCH)
if ! command -v eza &>/dev/null; then
  curl -fsSL -o /tmp/eza.tar.gz "https://github.com/eza-community/eza/releases/latest/download/eza_${YAZI_ARCH}.tar.gz"
  tar -C /tmp -xzf /tmp/eza.tar.gz eza
  sudo install -m 755 /tmp/eza /usr/local/bin/eza
  rm -f /tmp/eza.tar.gz /tmp/eza
  log_success "Eza installed"
else
  log_warning "Eza already installed, skipping"
fi
echo ""

# ============================================================================
# 7. Install Mise
# ============================================================================
log_info "Step 7/18: Installing Mise..."
if ! command -v mise &>/dev/null; then
  curl -fsSL https://mise.run | sh
  log_success "Mise installed"
else
  log_warning "Mise already installed, skipping"
fi
echo ""

# ============================================================================
# 8. Install Bun
# ============================================================================
log_info "Step 8/18: Installing Bun..."
if ! command -v bun &>/dev/null; then
  curl -fsSL https://bun.sh/install | bash
  log_success "Bun installed"
else
  log_warning "Bun already installed, skipping"
fi
echo ""

# ============================================================================
# 9. Install Yazi
# ============================================================================
log_info "Step 9/18: Installing Yazi file manager..."
if ! command -v yazi &>/dev/null; then
  curl -fsSL -o yazi.zip "https://github.com/sxyazi/yazi/releases/latest/download/yazi-${YAZI_ARCH}.zip"
  unzip -q yazi.zip
  sudo install -m 755 "yazi-${YAZI_ARCH}/yazi" /usr/local/bin/yazi
  sudo install -m 755 "yazi-${YAZI_ARCH}/ya" /usr/local/bin/ya
  rm -rf yazi.zip "yazi-${YAZI_ARCH}"
  log_success "Yazi installed"
else
  log_warning "Yazi already installed, skipping"
fi
echo ""

# ============================================================================
# 10. Install LazyGit and LazyDocker
# ============================================================================
log_info "Step 10/18: Installing lazygit and lazydocker..."

# LazyGit
log_info "Installing lazygit..."
if ! command -v lazygit &>/dev/null; then
  LAZYGIT_VERSION=$(curl -fsSL "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*' || true)
  if [ -z "$LAZYGIT_VERSION" ]; then
    log_warning "Could not determine latest lazygit version (GitHub API), skipping — rerun later"
  else
    curl -fsSL -o lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_${GH_ARCH}.tar.gz"
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit /usr/local/bin
    rm lazygit.tar.gz lazygit
    log_success "LazyGit installed"
  fi
else
  log_warning "LazyGit already installed, skipping"
fi

# LazyDocker
log_info "Installing lazydocker..."
if ! command -v lazydocker &>/dev/null; then
  LAZYDOCKER_VERSION=$(curl -fsSL "https://api.github.com/repos/jesseduffield/lazydocker/releases/latest" | grep -Po '"tag_name": "v\K[^"]*' || true)
  if [ -z "$LAZYDOCKER_VERSION" ]; then
    log_warning "Could not determine latest lazydocker version (GitHub API), skipping — rerun later"
  else
    curl -fsSL -o lazydocker.tar.gz "https://github.com/jesseduffield/lazydocker/releases/latest/download/lazydocker_${LAZYDOCKER_VERSION}_Linux_${GH_ARCH}.tar.gz"
    tar xf lazydocker.tar.gz lazydocker
    sudo install lazydocker /usr/local/bin
    rm lazydocker.tar.gz lazydocker
    log_success "LazyDocker installed"
  fi
else
  log_warning "LazyDocker already installed, skipping"
fi

log_success "lazygit and lazydocker installed"
echo ""

# ============================================================================
# 11. Install Optional/Fun Tools (pigz, chafa, asciiquarium)
# ============================================================================
log_info "Step 11/18: Installing optional tools..."

# Pigz
sudo apt install -y pigz

# Chafa
sudo apt install -y chafa

# Asciiquarium — non-fatal: a fun tool must not kill the setup
log_info "Installing asciiquarium..."
if command -v asciiquarium &>/dev/null; then
  log_warning "asciiquarium already installed, skipping"
elif sudo apt install -y libcurses-perl libterm-animation-perl &&
  wget -q https://www.robobunny.com/projects/asciiquarium/asciiquarium.tar.gz -O /tmp/asciiquarium.tar.gz &&
  (cd /tmp && tar -zxf asciiquarium.tar.gz && cd asciiquarium* &&
    sudo cp asciiquarium /usr/local/bin/ &&
    sudo chmod +x /usr/local/bin/asciiquarium &&
    rm -rf /tmp/asciiquarium.tar.gz /tmp/asciiquarium*); then
  log_success "asciiquarium installed"
else
  log_warning "asciiquarium install failed (non-fatal), skipping"
fi

log_success "Optional tools installed"
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
if command -v ya &>/dev/null; then
  ya pkg install
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

# Change default shell (sudo chsh: plain chsh reads the password from stdin,
# which is the script pipe when run via curl | bash)
if [ "$SHELL" != "$FISH_PATH" ]; then
  log_info "Changing default shell to Fish..."
  sudo chsh -s "$FISH_PATH" "$USER"
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
# 17. Install Neovim (GitHub release — apt's neovim is too old for LazyVim)
# ============================================================================
log_info "Step 17/18: Installing Neovim..."
# ponytail: /latest/download/ needs no GitHub API call (and can't die on rate limits
# or an empty grep under `set -e`). Version check skipped: apt neovim is never
# installed here, so an existing nvim already came from this script.
if nvim --version >/dev/null 2>&1; then
  log_warning "Neovim $(nvim --version | head -1) already installed, skipping"
else
  curl -fsSL -o /tmp/nvim.tar.gz "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-${NVIM_ARCH}.tar.gz"
  sudo tar -C /opt -xzf /tmp/nvim.tar.gz
  sudo ln -sfn "/opt/nvim-linux-${NVIM_ARCH}/bin/nvim" /usr/local/bin/nvim
  rm /tmp/nvim.tar.gz
  log_success "Neovim installed: $(nvim --version | head -1)"
fi
log_info "Neovim plugins will be installed automatically on first run"
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
echo "  • File management: yazi, eza"
echo "  • Development: bun, lazygit, lazydocker"
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
