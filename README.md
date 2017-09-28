# Video encoding script

Uses [HandBrakeCLI](https://handbrake.fr/downloads2.php) to encode all *.mp4 video files in \[src_dir\] and places them into \[dest_dir\].

## Install HandBrakeCLI
```bash
brew update
brew install handbrake
```
## Usage
```bash
./encode-videos.sh [src_dir] [dest_dir]
```
- Following encoding settings are used:
  `--encoder x264 --quality 20 --rate 30 --ab 64 --maxWidth 720 --optimize`
- A marker file (`.last_processed`) containing the name of the last processed
video will be written to the source directory. Next time the script is 
executed against the same source directory it will only encode files that 
are newer than the last one processed.
