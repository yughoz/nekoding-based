#!/bin/bash
# Encode clips for scroll scrubbing: native res, crf 20, GOP 8, no audio, faststart.
# Also makes the -m.mp4 mobile variant (720p, GOP 4, crf 23).
# Usage: ./encode.sh <in.mp4> <out-name>   e.g. ./encode.sh work/clips/dive_farm.mp4 farm
set -e
in="$1"; name="$2"
[ -z "$in" ] || [ -z "$name" ] && { echo "usage: encode.sh <in.mp4> <out-name>"; exit 1; }

# desktop
ffmpeg -v error -y -i "$in" -an -vf "unsharp=5:5:0.8:5:5:0.0" \
  -c:v libx264 -preset slow -crf 20 -pix_fmt yuv420p \
  -g 8 -keyint_min 8 -sc_threshold 0 -movflags +faststart "assets/vid/${name}.mp4"
echo "enc assets/vid/${name}.mp4 $(du -h "assets/vid/${name}.mp4" | cut -f1)"

# mobile
ffmpeg -v error -y -i "$in" -an -vf "scale=-2:720,unsharp=5:5:0.6:5:5:0.0" \
  -c:v libx264 -preset slow -crf 23 -pix_fmt yuv420p \
  -g 4 -keyint_min 4 -sc_threshold 0 -movflags +faststart "assets/vid/${name}-m.mp4"
echo "enc assets/vid/${name}-m.mp4 $(du -h "assets/vid/${name}-m.mp4" | cut -f1)"
