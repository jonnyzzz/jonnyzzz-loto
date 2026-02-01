#!/bin/bash
# Setup Qwen3-TTS on Mac Apple Silicon
# This enables local TTS with voice cloning and voice design

set -e

echo "=== Setting up Qwen3-TTS for Mac ==="
echo ""

# Check for brew
if ! command -v brew &> /dev/null; then
    echo "Error: Homebrew not found. Install from https://brew.sh"
    exit 1
fi

# Install required system dependencies
echo "Installing system dependencies..."
brew install sox portaudio 2>/dev/null || true

# Clone Qwen3-TTS if not present
if [ ! -d "Qwen3-TTS" ]; then
    echo "Cloning Qwen3-TTS repository..."
    git clone https://github.com/QwenLM/Qwen3-TTS.git
else
    echo "Qwen3-TTS repository already exists"
fi

# Sync dependencies
echo "Installing Python dependencies..."
uv sync --extra qwen --extra listen

# Create models directory
mkdir -p models

# Download models
echo ""
echo "Downloading Qwen3-TTS models..."
echo "This may take a while (each model is ~4GB)..."
echo ""

# VoiceDesign model (recommended for Russian voices)
if [ ! -d "models/Qwen3-TTS-12Hz-1.7B-VoiceDesign" ]; then
    echo "Downloading VoiceDesign model (1.7B - recommended)..."
    uv run huggingface-cli download Qwen/Qwen3-TTS-12Hz-1.7B-VoiceDesign \
        --local-dir ./models/Qwen3-TTS-12Hz-1.7B-VoiceDesign
else
    echo "VoiceDesign model already downloaded"
fi

# Optional: Base model for voice cloning
if [ "$1" == "--all" ]; then
    if [ ! -d "models/Qwen3-TTS-12Hz-1.7B-Base" ]; then
        echo "Downloading Base model (1.7B - for voice cloning)..."
        uv run huggingface-cli download Qwen/Qwen3-TTS-12Hz-1.7B-Base \
            --local-dir ./models/Qwen3-TTS-12Hz-1.7B-Base
    fi

    if [ ! -d "models/Qwen3-TTS-12Hz-0.6B-Base" ]; then
        echo "Downloading Base model (0.6B - faster)..."
        uv run huggingface-cli download Qwen/Qwen3-TTS-12Hz-0.6B-Base \
            --local-dir ./models/Qwen3-TTS-12Hz-0.6B-Base
    fi
fi

echo ""
echo "=== Setup complete! ==="
echo ""
echo "Available models:"
ls -d models/*/ 2>/dev/null | while read dir; do
    size=$(du -sh "$dir" 2>/dev/null | cut -f1)
    name=$(basename "$dir")
    echo "  - $name ($size)"
done
echo ""
echo "Run the game:"
echo "  uv run python loto.py --qwen                    # VoiceDesign (recommended)"
echo "  uv run python loto.py --qwen --model-type base  # Voice cloning (needs samples)"
echo ""
echo "For voice cloning, place voice samples in ./voices/ directory"
echo ""
