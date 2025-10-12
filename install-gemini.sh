#!/usr/bin/env bash
set -e

echo "Starting installation of Docker and Google Gemini CLI..."

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

# --- Verify install ---
echo "Checking installations..."
docker --version
node --version
gemini --version

echo "Installation complete!"
echo "Run 'gemini auth login' to connect your Google account."
