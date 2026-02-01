# Voice Samples for Qwen TTS Cloning

Place 5-15 second audio clips here for voice cloning:

- `brezhnev.mp3` - Леонид Брежнев speech sample
- `galkin.mp3` - Максим Галкин voice sample
- `pugacheva.mp3` - Алла Пугачёва singing/speaking
- `vinni.mp3` - Евгений Леонов as Винни-Пух
- `zhirinovsky.mp3` - Владимир Жириновский speech

## Where to find samples

- Brezhnev: https://zvukogram.com/category/zvuk-brejneva/
- Vinni-Puh: https://zvukipro.com/mult/2937-zvuki-iz-sovetskogo-multfilma-vinni-puh.html
- Zhirinovsky: https://zvukipro.com/zvukiludei/1831-zvuki-s-golosom-zhirinovskogo-vladimira-volfovicha.html

## Requirements

- Clean audio, no background noise
- 5-15 seconds of speech
- MP3, WAV, or OGG format
- Clear pronunciation

Run with `--qwen` flag to use voice cloning:
```bash
uv run python loto.py --qwen
```
