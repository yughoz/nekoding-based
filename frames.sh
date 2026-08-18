#!/bin/bash
# Extract first & last frame from each dive clip (seam handoff frames).
# Usage: ./frames.sh <clip.mp4> <name>
# Produces work/frames/first_<name>.png and work/frames/last_<name>.png
set -e
clip="$1"; name="$2"
[ -z "$clip" ] || [ -z "$name" ] && { echo "usage: frames.sh <clip.mp4> <name>"; exit 1; }
ffmpeg -v error -y -ss 0 -i "$clip" -frames:v 1 -q:v 2 "work/frames/first_${name}.png"
ffmpeg -v error -y -sseof -0.15 -i "$clip" -frames:v 1 -q:v 2 "work/frames/last_${name}.png"
echo "frames for $name ok"
