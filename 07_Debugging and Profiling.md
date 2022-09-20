
# 7- Debugging and Profiling

## Exercise

Q1. Use journalctl on Linux or log show on macOS to get the super user accesses and commands in the last day. If there aren’t any you can execute some harmless commands such as sudo ls and check again

```sh
sudo ls .
journalctl --since yesterday
# returns --No entries--
# journalctl based on systemd, which is disabled in WSL2 
# no files at /var/log/syslog or /var/log/journal/*
```

```sh
sudo service rsyslog start # start syslog in wsl
logger "hello logs"
cat /var/log/syslog | grep hello
```

Q2. Do this hands on pdb tutorial to familiarize yourself with the commands. For a more in depth tutorial read this

Q3. Install shellcheck and try checking the following script. What is wrong with the code? Fix it. Install a linter plugin in your editor so you can get your warnings automatically

```sh
# On Debian based distros
sudo apt install shellcheck
shellcheck 07shellcheck.sh -s bash
```

Install shell-format pluggin on VScode based on shellcheck
Q4. (Advanced) Read about reversible debugging and get a simple example working using rr or RevPDB.

Q5. Here are some sorting algorithm implementations. Use cProfile and line_profiler to compare the runtime of insertion sort and quicksort. What is the bottleneck of each algorithm? Use then memory_profiler to check the memory consumption, why is insertion sort better? Check now the inplace version of quicksort. Challenge: Use perf to look at the cycle counts and cache hits and misses of each algorithm

```bash
# Check runtime with cprofile
python -m cProfile -s time 07sorts.py
python -m cProfile -s time 07sorts.py | grep 07sorts.py
```

```bash
# Check bottleneck with line profiler
pip install line_profiler
# decorate function to be tested with @profile and run 
kernprof -l -v 07sorts.py
```

```bash
# Check memory profiler
pip install memory_profiler
# decorate function to be tested with @profile and run 
python -m memory_profiler 07sorts.py
```

```bash
# Check cycle counts and cache hits and misses
sudo apt-get install linux-tools-common linux-tools-generic 
# not available in WSL 2 : https://github.com/microsoft/WSL/issues/8480
```
