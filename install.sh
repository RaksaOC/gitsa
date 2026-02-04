#!/usr/bin/env bash

set -e

### Paths
INSTALL_DIR="/usr/local/lib/gitsa"
BIN_DIR="/usr/local/bin"
BIN_NAME="gitsa"
CONFIG_DIR="$HOME/.config/gitsa"
CONFIG_FILE="$CONFIG_DIR/gitsa_config.sh"
CONFIG_EXAMPLE="config/gitsa_config_example.sh"

### Colors (minimal, installer-safe)
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${CYAN}▶ Installing gitsa...${NC}"

### Require sudo for system directories
if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}ERROR:${NC} Please run with sudo:"
  echo "  sudo ./install.sh"
  exit 1
fi

### Remove old install if exists
if [ -d "$INSTALL_DIR" ]; then
  echo -e "${YELLOW}• Removing existing install at $INSTALL_DIR${NC}"
  rm -rf "$INSTALL_DIR"
fi

### Move project
echo -e "${CYAN}• Installing files to $INSTALL_DIR${NC}"
mkdir -p /usr/local/lib
cp -R . "$INSTALL_DIR"

### Install entry point
echo -e "${CYAN}• Installing binary to $BIN_DIR/$BIN_NAME${NC}"
chmod +x "$INSTALL_DIR/bin/gitsa.sh"
ln -sf "$INSTALL_DIR/bin/gitsa.sh" "$BIN_DIR/$BIN_NAME"

### User config
echo -e "${CYAN}• Setting up user config${NC}"
mkdir -p "$CONFIG_DIR"

if [ ! -f "$CONFIG_FILE" ]; then
  if [ -f "$INSTALL_DIR/$CONFIG_EXAMPLE" ]; then
    cp "$INSTALL_DIR/$CONFIG_EXAMPLE" "$CONFIG_FILE"
  else
    # fallback empty config
    cat > "$CONFIG_FILE" <<'EOF'
#!/usr/bin/env bash

# Telegram
TELEGRAM_BOT_TOKEN=""
CHAT_ID=""

# AI
SUMMARY_AI_KEY=""

# Git remote validation
REMOTE_NAMES=()
REMOTE_URLS=()
ALLOW_ONE_MATCH="false"
EOF
  fi
  chmod 600 "$CONFIG_FILE"
fi

echo
echo -e "${GREEN}✔ gitsa installed successfully!${NC}"
echo
echo -e "Next steps:"
echo -e "  1. Edit your config:"
echo -e "     ${CYAN}gitsa --config${NC}"
echo
echo -e "  2. Use the tool:"
echo -e "     ${CYAN}gitsa commit${NC}"
echo
