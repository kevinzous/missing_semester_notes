#!/bin/sh
## Example: a typical script with several problems
for f in ./*.m3u  # command expansion causes word splitting and glob expansion
                  # which will cause problems for certain filenames 
                  # (typically first seen when trying to process a file with spaces in the name)
                  # https://github.com/koalaman/shellcheck/wiki/SC2045#rationale
      do      
  grep -qi  'hq.*mp3' "$f" \
    && echo -e "Playlist $f contains a HQ file in mp3 format"
done
