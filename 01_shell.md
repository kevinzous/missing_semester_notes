# Course overview + the shell

## Exercises
 1. For this course, you need to be using a Unix shell like Bash or ZSH. If you
    are on Linux or macOS, you don't have to do anything special. If you are on
    Windows, you need to make sure you are not running cmd.exe or PowerShell;
    you can use [Windows Subsystem for
    Linux](https://docs.microsoft.com/en-us/windows/wsl/) or a Linux virtual
    machine to use Unix-style command-line tools. To make sure you're running
    an appropriate shell, you can try the command `echo $SHELL`. If it says
    something like `/bin/bash` or `/usr/bin/zsh`, that means you're running the
    right program.
 2. Create a new directory called `missing` under `/tmp`.

```bash
mkdir missing
cd missing
```

 3. Look up the `touch` program. The `man` program is your friend.
 4. Use `touch` to create a new file called `semester` in `missing`.

```bash
touch --help
man touch
touch semester
```

 5. Write the following into that file, one line at a time:
    ```
    #!/bin/sh
    curl --head --silent https://missing.csail.mit.edu
    ```
    The first line might be tricky to get working. It's helpful to know that
    `#` starts a comment in Bash, and `!` has a special meaning even within
    double-quoted (`"`) strings. Bash treats single-quoted strings (`'`)
    differently: they will do the trick in this case. See the Bash
    [quoting](https://www.gnu.org/software/bash/manual/html_node/Quoting.html)
    manual page for more information.

```bash
## shebang (#!) : executable in a Unix-like OS
echo "#!/bin/sh" > semester
## append line to the file
echo "curl --head --silent https://missing.csail.mit.edu" >> semester
## print file content to check
cat semester
```

 6. Try to execute the file, i.e. type the path to the script (`./semester`)
    into your shell and press enter. Understand why it doesn't work by
    consulting the output of `ls` (hint: look at the permission bits of the
    file).

 7. Run the command by explicitly starting the `sh` interpreter, and giving it
    the file `semester` as the first argument, i.e. `sh semester`. Why does
    this work, while `./semester` didn't?

```bash
./semester    # asks the kernel to run semester as a program, and the
              # kernal (program loader) will check permissions first,
              # and then use /bin/bash (or sh or zsh etc) to starts
              # a new instance of bash and execute the script.
sh semester   # asks the kernel (program loader) to run /bin/sh,
              # not sh semester as the program so the execute permissions
              # of the file do not matter.

# source semester execute semester in the current bash session
```

 8. Look up the `chmod` program (e.g. use `man chmod`).
 9. Use `chmod` to make it possible to run the command `./semester` rather than
    having to type `sh semester`. How does your shell know that the file is
    supposed to be interpreted using `sh`? See this page on the
    [shebang](https://en.wikipedia.org/wiki/Shebang_(Unix)) line for more
    information.

```bash
man chmod
chmod +x semester
```

 10. Use `|` and `>` to write the "last modified" date output by
    `semester` into a file called `last-modified.txt` in your home
    directory.

```bash
ls -l semester | tail -c  23 | head -c 12 > last-modified.txt
```

 11. Write a command that reads out your laptop battery's power level or your
    desktop machine's CPU temperature from `/sys`. Note: if you're a macOS
    user, your OS doesn't have sysfs, so you can skip this exercise.
