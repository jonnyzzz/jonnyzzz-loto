#!/bin/bash
# Setup Qwen3-TTS on Mac Apple Silicon
# This enables real voice cloning with celebrity voice samples

set -e

echo "=== Setting up Qwen3-TTS for Mac ==="

# Install LLVM if needed
if ! brew list llvm@20 &>/dev/null; then
    echo "Installing LLVM 20..."
    brew install llvm@20
fi

export PATH="/opt/homebrew/opt/llvm@20/bin:/usr/local/opt/llvm@20/bin:$PATH"
export CMAKE_PREFIX_PATH="/opt/homebrew/opt/llvm@20:/usr/local/opt/llvm@20"

# Clone Qwen3-TTS if not present
if [ ! -d "Qwen3-TTS" ]; then
    echo "Cloning Qwen3-TTS repository..."
    git clone https://github.com/QwenLM/Qwen3-TTS.git
fi

# Install from source
echo "Installing Qwen3-TTS..."
uv add ./Qwen3-TTS
uv add 'huggingface-hub[cli]'
uv add 'numpy<2'

# Download the smaller model (0.6B for faster performance)
echo "Downloading Qwen3-TTS model (this may take a while)..."
mkdir -p models
huggingface-cli download Qwen/Qwen3-TTS-12Hz-0.6B-Base \
    --local-dir ./models/Qwen3-TTS-12Hz-0.6B-Base

echo ""
echo "=== Setup complete! ==="
echo ""
echo "Now place your voice samples in ./voices/ directory:"
echo "  - brezhnev.mp3"
echo "  - galkin.mp3"
echo "  - pugacheva.mp3"
echo "  - vinni.mp3"
echo "  - zhirinovsky.mp3"
echo ""
echo "Then run: uv run python loto.py --qwen"
