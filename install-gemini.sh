#!/usr/bin/env bash
set -e

echo "Starting installation of Docker and Google Gemini CLI..."

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "✅ linux installed."
    
    # --- Debian/Ubuntu ---
    if command -v apt-get >/dev/null 2>&1; then
        echo "Debian/Ubuntu system detected."
        sudo apt-get update -y
        sudo apt-get install -y curl ca-certificates gnupg lsb-release

        # --- Install Docker ---
        if ! command -v docker >/dev/null 2>&1; then
            echo "Installing Docker..."
            sudo mkdir -p /etc/apt/keyrings
            curl -fsSL https://download.docker.com/linux/$(. /etc/os-release && echo "$ID")/gpg \
                | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
            echo \
              "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
              https://download.docker.com/linux/$(. /etc/os-release && echo "$ID") \
              $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
            sudo apt-get update -y
            sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
            sudo systemctl enable docker
            sudo systemctl start docker
        else
            echo "✅ Docker already installed."
        fi

        # --- Install Node.js ---
        if ! command -v node >/dev/null 2>&1; then
            echo "Installing Node.js (LTS)..."
            curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
            sudo apt-get install -y nodejs
        else
            echo "✅ Node.js already installed."
        fi
    # --- RHEL/CentOS/Fedora --- 
    elif command -v dnf >/dev/null 2>&1; then
        echo "RHEL/CentOS/Fedora system detected."
        sudo dnf -y install dnf-plugins-core curl
        sudo dnf -y update

        # --- Install Docker ---
        if ! command -v docker >/dev/null 2>&1; then
            echo "🐳 Installing Docker..."
            sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
            sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
            sudo systemctl enable docker
            sudo systemctl start docker
        else
            echo "✅ Docker already installed."
        fi

        # --- Install Node.js ---
        if ! command -v node >/dev/null 2>&1; then
            echo "📦 Installing Node.js (LTS)..."
            curl -fsSL https://rpm.nodesource.com/setup_lts.x | sudo bash -
            sudo dnf install -y nodejs
        else
            echo "✅ Node.js already installed."
        fi
    # --- UNSUPPORTED ---  
    else
        echo "❌ Unsupported Linux distribution."
        exit 1
    fi
    
    # --- Install Google Gemini CLI ---
    if ! command -v gemini >/dev/null 2>&1; then
        echo "✨ Installing Google Gemini CLI..."
        npm install -g @google/gemini-cli
    else
        echo "✅ Gemini CLI already installed."
    fi

elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "✅ MacOS installed."
    
    # --- Check for Homebrew ---
    if ! command -v brew >/dev/null 2>&1; then
      echo "🍺 Homebrew not found. Installing Homebrew..."
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      eval "$(/opt/homebrew/bin/brew shellenv)" || eval "$(/usr/local/bin/brew shellenv)"
    else
      echo "✅ Homebrew installed."
    fi

    # --- Install Docker ---
    if ! command -v docker >/dev/null 2>&1; then
      echo "🐳 Installing Docker Desktop..."
      brew install --cask docker
      open /Applications/Docker.app || true
      echo "⏳ Waiting for Docker to start..."
      while ! docker info >/dev/null 2>&1; do
        sleep 2
      done
    else
      echo "✅ Docker installed."
    fi
    
    # --- Install Node.js ---
    if ! command -v node >/dev/null 2>&1; then
      echo "📦 Installing Node.js..."
      brew install node
    else
      echo "✅ Node.js installed."
    fi
    
    # --- Install Google Gemini CLI ---
    if ! command -v gemini >/dev/null 2>&1; then
      echo "✨ Installing Google Gemini CLI..."
      npm install -g @google/gemini-cli
    else
      echo "✅ Gemini CLI installed."
    fi
else
  echo "Unknown OS for operation. Sorry."
  exit 0
fi

# --- Verify install ---
echo "Checking installations..."
docker --version
node --version
gemini --version

echo "Installation complete!"
echo "Run 'gemini auth login' to connect your Google account."
