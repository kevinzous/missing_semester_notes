# draft

Get the output of a command as a variable (command substitution) ! :
$( CMD )

```bash
convert image.{png,jpg}
# Curly braces will expand the command
convert image.png image.jpg

cp /path/to/project/{foo,bar,baz}.sh /newpath
# Will expand to
cp /path/to/project/foo.sh /path/to/project/bar.sh /path/to/project/baz.sh /newpath

# Globbing techniques can also be combined
mv *{.py,.sh} folder
# Will move all*.py and *.sh files

mkdir foo bar

# This creates files foo/a, foo/b, ... foo/h, bar/a, bar/b, ... bar/h

touch {foo,bar}/{a..h}
touch foo/x bar/y

# Show differences between files in foo and bar
diff <(ls foo) <(ls bar)
# Process substitution, <( CMD ) will execute CMD and place the output in a temporary file and substitute the <() with that file’s name.
# This is useful when commands expect values to be passed by file instead of by STDIN.
# For example, diff <(ls foo) <(ls bar) will show differences between files in dirs foo and bar.

# Find all directories named src
find . -name src -type d

# Find all python files that have a folder named test in their path
find . -path '*/test/*.py' -type f

# Find all files modified in the last day
find . -mtime -1

# Find all zip files with size in range 500k to 10M
find . -size +500k -size -10M -name '*.tar.gz'

# Find all python files where I used the requests library
rg -t py 'import requests'

# Find all files (including hidden files) without a shebang line
rg -u --files-without-match "^#!"

# Find all matches of foo and print the following 5 lines
rg foo -A 5

# Print statistics of matches (# of matched lines and files )

rg --stats PATTERN
```
