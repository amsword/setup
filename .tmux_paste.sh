#!/bin/bash
# tmux-paste.sh

# Get clipboard content using pbpaste
content=$(pbpaste)

# Check if the content is large and needs to be split
max_length=10000  # Adjust this value as needed
if [ ${#content} -gt $max_length ]; then
  echo "Content too large, splitting and pasting in chunks..."
  echo "$content" | fold -w $max_length | while read -r line; do
    tmux set-buffer "$line"
    tmux paste-buffer
    sleep 0.1  # Small delay to allow tmux to process each chunk
  done
else
  tmux set-buffer "$content"
  tmux paste-buffer
fi

