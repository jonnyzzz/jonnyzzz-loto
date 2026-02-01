# Russian Loto with AI Voices 🎰

A Russian Loto (Bingo) game announcer with AI-generated character voices. Each character has a unique personality and tells jokes for every number from 1-90.

The game uses [Qwen3-TTS](https://github.com/QwenLM/Qwen3-TTS) VoiceDesign model to generate native Russian voices from text descriptions—no voice samples required.

## Features

- **12 distinct character voice personalities** - each with unique speech patterns
- **Character-specific jokes** for all 90 numbers
- **VoiceDesign model** - generates voices from text descriptions (no samples needed)
- **Noise detection** - waits for quiet room with exponential backoff
- **Local inference** - runs entirely on your machine, no cloud APIs
- **Apple Silicon support** - MPS GPU acceleration on Mac

## Quick Start

```bash
# Clone the repository
git clone https://github.com/jonnyzzz/jonnyzzz-loto.git
cd jonnyzzz-loto

# Setup (downloads models, ~4GB)
./setup_qwen_mac.sh

# Run the game
uv run python loto.py --qwen
```

## Requirements

- Python 3.11+
- [uv](https://github.com/astral-sh/uv) package manager
- macOS with Apple Silicon (M1/M2/M3) or NVIDIA GPU
- ~4GB disk space for the TTS model

## Installation

### Mac (Apple Silicon)

```bash
# Install dependencies and download model
./setup_qwen_mac.sh

# Or manually:
brew install sox portaudio
uv sync --extra qwen --extra listen
```

### Download All Models (Optional)

```bash
# Download all model variants (~15GB total)
./setup_qwen_mac.sh --all
```

## Usage

### Basic Usage

```bash
# Run with AI voices (VoiceDesign - recommended)
uv run python loto.py --qwen

# Run with edge-tts fallback (no GPU required)
uv run python loto.py
```

### Options

```bash
# Specify number count
uv run python loto.py --qwen --count 30

# Use larger model for better quality
uv run python loto.py --qwen --model-size large

# Use voice cloning mode (requires voice samples in ./voices/)
uv run python loto.py --qwen --model-type base

# Enable noise detection (reacts to room noise)
uv run python loto.py --qwen --listen

# Adjust delays between numbers
uv run python loto.py --qwen --min-delay 2.0 --max-delay 4.0
```

### Command-Line Arguments

| Argument | Default | Description |
|----------|---------|-------------|
| `-n, --count` | 90 | Number of loto numbers to announce |
| `--min-delay` | 1.0 | Minimum delay between numbers (seconds) |
| `--max-delay` | 2.0 | Maximum delay between numbers (seconds) |
| `--qwen` | false | Use Qwen3-TTS for voice generation |
| `--model-size` | large | Model size: `small` (0.6B) or `large` (1.7B) |
| `--model-type` | design | Model type: `design` (text-to-voice) or `base` (voice cloning) |
| `--listen` | false | Enable noise detection mode |
| `--noise-threshold` | 500 | Noise threshold for detection |

## Voice Characters

The game includes 12 character archetypes, each with distinct voice characteristics:

| Character Type | Voice Style | Personality |
|---------------|-------------|-------------|
| Soviet Leader | Deep, slow, deliberate | Bureaucratic humor, five-year plans |
| Showman | Energetic, theatrical | Game show enthusiasm |
| Pop Diva | Dramatic, expressive | Primadonna flair |
| Cartoon Bear | Warm, friendly | Honey and friendship |
| Politician | Loud, passionate | Political outbursts |
| Indie Singer | Young, ironic | Gen-Z slang |
| Punk Rocker | Theatrical, dark | Gothic horror humor |
| Bard | Raspy, poetic | Existential observations |
| Rock Star | Rough, provocative | Street humor |
| Pop King | Grandiose, flamboyant | Over-the-top celebrations |
| Rock Balladeer | Powerful, emotional | Dramatic weight |
| Opera Tenor | Melodic, charming | Classical elegance |

## Example Jokes

Each character has unique jokes for every number. Here are some examples:

### Number 5 (Пять / Pyat')

**Soviet Leader style:**
> «Пять... Пятилетка! Выполним и перевыполним план! Пятёрка!»
>
> *"Five... Five-year plan! We will fulfill and exceed the plan! A five!"*

**Punk Rocker style:**
> «Пять! Пять пальцев тянутся из могилы! Ха-ха! Пять!»
>
> *"Five! Five fingers reaching from the grave! Ha-ha! Five!"*

### Number 13 (Тринадцать / Trinadtsat')

**Cartoon Bear style:**
> «Тринадцать... Говорят, несчастливое... Но мёд-то есть! Значит счастье! Тринадцать!»
>
> *"Thirteen... They say it's unlucky... But there's honey! So it's happiness! Thirteen!"*

**Gothic Horror style:**
> «Тринадцать! Моё любимое число! Ха-ха-ха! Пятница тринадцатое! Тринадцать!»
>
> *"Thirteen! My favorite number! Ha-ha-ha! Friday the 13th! Thirteen!"*

### Number 42 (Сорок два / Sorok dva)

**Bard style:**
> «Сорок два... Ответ на главный вопрос... Но какой вопрос? Сорок два!»
>
> *"Forty-two... The answer to the ultimate question... But what's the question? Forty-two!"*

### Number 77 (Семьдесят семь / Semdesyat sem')

**Opera Tenor style:**
> «Семьдесят семь! Две семёрки! Двойная удача! Ария победы! Семьдесят семь!»
>
> *"Seventy-seven! Two sevens! Double luck! Victory aria! Seventy-seven!"*

## How VoiceDesign Works

Instead of cloning voices from audio samples, VoiceDesign generates voices from text descriptions:

```python
voice_description = """
A deep elderly male Russian voice speaking with
slow deliberate speech and long dramatic pauses.
Authoritative tone with slight speech impediment.
"""
# The model generates voice parameters from the description
# No audio samples required
```

This approach:
- Requires no voice samples to collect
- Generates consistent character voices
- Supports native Russian pronunciation
- Works entirely locally

## Noise Detection

The `--listen` mode uses your microphone to detect room noise:

- **Waits for quiet** before announcing numbers
- **Exponential backoff** - increasingly insistent attention-getters
- **Repeats last number** when room gets quiet again

```bash
# Enable noise detection
uv run python loto.py --qwen --listen --noise-threshold 300
```

## Project Structure

```
jonnyzzz-loto/
├── loto.py              # Main game logic
├── pyproject.toml       # Dependencies
├── setup_qwen_mac.sh    # Setup script for Mac
├── LICENSE              # MIT License
├── voices/              # Voice samples for cloning (optional)
│   └── README.md
└── models/              # Downloaded TTS models (gitignored)
    ├── Qwen3-TTS-12Hz-1.7B-VoiceDesign/
    └── ...
```

## Models

| Model | Size | Use Case |
|-------|------|----------|
| Qwen3-TTS-12Hz-1.7B-VoiceDesign | 4.2GB | Generate voices from descriptions (recommended) |
| Qwen3-TTS-12Hz-1.7B-Base | 4.2GB | Voice cloning with audio samples |
| Qwen3-TTS-12Hz-0.6B-Base | 2.3GB | Faster voice cloning |

## Performance

On Apple Silicon (M1/M2/M3):
- Audio generation: ~2-3 seconds per phrase
- First run: generates audio in real-time
- MPS GPU acceleration enabled automatically

## Troubleshooting

### "No module named 'qwen_tts'"

Run the setup script:
```bash
./setup_qwen_mac.sh
```

### Slow generation

The first run downloads models (~4GB). Subsequent runs are faster.

### No sound

Check pygame audio:
```bash
uv run python -c "import pygame; pygame.mixer.init(); print('OK')"
```

### MPS errors on Mac

The game uses float32 precision for MPS stability. If issues persist, it falls back to CPU.

## Contributing

Contributions welcome! Ideas:
- Add more character jokes
- Improve voice descriptions
- Add new character archetypes
- Support other languages

## License

MIT License - see [LICENSE](LICENSE) file.

## Credits

- [Qwen3-TTS](https://github.com/QwenLM/Qwen3-TTS) by Alibaba (Apache 2.0)
- [edge-tts](https://github.com/rany2/edge-tts) for fallback TTS
- [pygame](https://www.pygame.org/) for audio playback

## Links

- [GitHub Repository](https://github.com/jonnyzzz/jonnyzzz-loto)
- [Blog Post](https://jonnyzzz.com/blog/2025/02/01/russian-loto-ai-voices/)
- [Author's Website](https://jonnyzzz.com)
