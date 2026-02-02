# Server-Performance-Stats
Bash script to collect basic Linux server performance stats (CPU, memory, disk, top processes, os version, uptime, load average, logged in users, failed login attempts ).


## Overview

Both scripts collect and display the following metrics:
- **CPU Usage**: Total CPU utilization percentage
- **Memory Usage**: Total, used, free memory with percentage
- **Disk Usage**: Total, used, free disk space with percentage
- **Top Processes**: Top 5 processes by CPU and memory usage
- **System Info**: OS version, uptime, load average
- **User Activity**: Logged-in users and failed login attempts

---

## `stats_1.sh` - Linear Script

### Description
A procedural script that executes all commands sequentially.

### Code Structure
- Direct command execution in a linear flow
- All output formatting done inline with echo statements

### Execution

#### Without `sudo` (may fail on `lastb` command):
```bash
./stats_1.sh
```

#### With `sudo` (recommended):
```bash
sudo ./stats_1.sh
```



## Approach 2: `stats_2.sh` - Modular Script with Functions

### Description
A modular version that uses functions for each statistic. This improves code reusability and makes it easier to extend or modify individual metrics.


### Function Overview

| Function | Purpose |
|----------|---------|
| `get_cpu_usage()` | Returns total CPU usage percentage |
| `get_memory_usage()` | Returns memory statistics |
| `get_disk_usage()` | Returns disk space statistics |
| `get_top_cpu_processes()` | Lists top 5 processes by CPU |
| `get_top_disk_processes()` | Lists top 5 processes by memory |
| `get_os_version()` | Returns OS kernel version |
| `get_uptime()` | Returns system uptime in human-readable format |
| `get_load_average()` | Returns load average metrics |
| `get_logged_in_users()` | Returns count of logged-in users |
| `get_failed_login_attempts()` | Returns count of failed login attempts |
| `main()` | Calls all functions and formats output |

### Execution

#### Without `sudo` (may fail on `lastb` command):
```bash
./stats_2.sh
```

#### With `sudo` (recommended to handle the permission to `lastb`):
```bash
sudo ./stats_2.sh
```

#### Using Individual Functions
You can source this script in other scripts and call specific functions:
```bash
source ./stats_2.sh
get_cpu_usage
get_memory_usage
```




## Handling `lastb` Permission Issues

The `lastb` command requires root privileges to read the failed login attempts from `/var/log/btmp`. Here are the possible options:

### Option 1: Run with `sudo` (Recommended)
```bash
sudo ./stats_1.sh
# or
sudo ./stats_2.sh
```




### Option 2: Error Handling 
Modify the `get_failed_login_attempts()` function to handle permission errors gracefully:

````bash
get_failed_login_attempts() {
    if lastb >/dev/null 2>&1; then
        lastb | wc -l
    else
        echo "N/A (requires root access)"
    fi
}