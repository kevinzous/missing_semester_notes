# Debugging and Profiling

## Exercise

### Debugging

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

Add following at the start of the python code
```python
import pdb; pdb.set_trace()
```
and run
```bash
python script.py
```

Q3. Install shellcheck and try checking the following script. What is wrong with the code? Fix it. Install a linter plugin in your editor so you can get your warnings automatically

```sh
# On Debian based distros
sudo apt install shellcheck
shellcheck 07shellcheck.sh -s bash
```

Install shell-format pluggin on VScode based on shellcheck

Q4. (Advanced) Read about reversible debugging and get a simple example working using rr or RevPDB.

### Profiling

Q5. Here are some sorting algorithm implementations. Use cProfile and line_profiler to compare the runtime of insertion sort and quicksort. What is the bottleneck of each algorithm? Use then memory_profiler to check the memory consumption, why is insertion sort better? Check now the inplace version of quicksort. Challenge: Use perf to look at the cycle counts and cache hits and misses of each algorithm

```bash
# Check runtime with cprofile
python -m cProfile -s time 07sorts.py
python -m cProfile -s time 07sorts.py | grep 07sorts.py
```

```bash
# Check bottleneck with line profiler
pip install line_profiler
kernprof -l -v 07sorts.py # decorate function to be tested with @profile before
```

```bash
# Check memory profiler
pip install memory_profiler
python -m memory_profiler 07sorts.py # decorate function to be tested with @profile before
```

```bash
# Check cycle counts and cache hits and misses
sudo apt-get install linux-tools-common linux-tools-generic
# not available in WSL 2 : https://github.com/microsoft/WSL/issues/8480
```

Q6. Here’s some (arguably convoluted) Python code for computing Fibonacci numbers using a function for each number.
Put the code into a file and make it executable. Install prerequisites: pycallgraph and graphviz. (If you can run dot, you already have GraphViz.) Run the code as is with pycallgraph graphviz -- ./fib.py and check the pycallgraph.png file. How many times is fib0 called?. We can do better than that by memoizing the functions. Uncomment the commented lines and regenerate the images. How many times are we calling each fibN function now?

```bash
sudo apt-get install graphviz # Install pycallgraph and graphviz
chmod +x 07fibonacci.py # make the script executable
pycallgraph graphviz --output-file=07pycallgraph.png ./07fibonacci.py
pycallgraph graphviz --output-file=07pycallgraph_memoization.png ./07fibonacci_memoization.py
```

<img src="07_files/07pycallgraph_memoization.png" alt="07pycallgraph_memoization" width="150"/>
<img src="07_files/07pycallgraph.png" alt="07pycallgraph" width="100"/>

By memoizing the functions, each fibN is called only once. This became apparent in terms of execution time when N is increased.

Q7. A common issue is that a port you want to listen on is already taken by another process. Let’s learn how to discover that process pid. First execute python -m http.server 4444 to start a minimal web server listening on port 4444. On a separate terminal run lsof | grep LISTEN to print all listening processes and ports. Find that process pid and terminate it by running kill \<PID>.

```bash
python -m http.server 4444
lsof | grep LISTEN
kill 28471
```

Q8. Limiting processes resources can be another handy tool in your toolbox. Try running stress -c 3 and visualize the CPU consumption with htop. Now, execute taskset --cpu-list 0,2 stress -c 3 and visualize it. Is stress taking three CPUs? Why not? Read man taskset. Challenge: achieve the same using cgroups. Try limiting the memory consumption of stress -m.

```bash
sudo apt-get install stress
uptime # see current system load averages
stress -c 3
htop # load average have increased from 0.10 to 3.5
     # 3 CPU are at 100% and taken by 3 processes
taskset --cpu-list 0,2 stress -c 3 # 2 CPU are at 100%
# the command "stress -c 3" is run on the given cpu provided in --cpu-list
# since only 2 CPU are provided, only those 2 are at 100%
```

Q9. (Advanced) The command curl ipinfo.io performs a HTTP request and fetches information about your public IP. Open Wireshark and try to sniff the request and reply packets that curl sent and received. (Hint: Use the http filter to just watch HTTP packets).
