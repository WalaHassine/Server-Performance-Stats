# Total CPU usage
get_cpu_usage() {
    top -bn1 | grep "Cpu(s)" | \
    sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | \
    awk '{print 100 - $1"%"}'
}
# Total memory usage (Free vs Used including percentage)
get_memory_usage() {
    free -h | grep Mem | awk '{print "Total: " $2 ", Used: " $3 ", Free: " $4 ", Percentage: " $3/$2*100 "%"}'
}

# Total disk usage (Free vs Used including percentage)
get_disk_usage() {
    df -h --total | grep total | awk '{print "Total: " $2 ", Used: " $3 ", Free: " $4 ", Percentage: " $5}'
}
# Top 5 processes by CPU usage
get_top_cpu_processes() {
    ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
}
# Top 5 processes by memory usage
get_top_disk_processes() {
    ps -eo pid,comm,%mem --sort=-%mem | head -n 6
}
# OS version
get_os_version() {
    uname -r
}
# Uptime
get_uptime() {
    uptime -p
}
# Load average
get_load_average() {
    uptime | awk -F'load average:' '{ print $2 }'
}
# Logged in users
get_logged_in_users() {
    who | wc -l
}
# Failed login attempts
get_failed_login_attempts() {
    lastb | wc -l
}
# main function to call all stats
main() {
    echo "===== Server Performance Stats ====="
    echo "-------------------------------"
    echo "Total CPU Usage:" 
    get_cpu_usage
    echo "-------------------------------"
    echo "Total Memory Usage:"
    get_memory_usage
    echo "-------------------------------"
    echo "Total Disk Usage:"
    get_disk_usage
    echo "-------------------------------"
    echo "Top 5 Processes by CPU Usage:"
    get_top_cpu_processes
    echo "-------------------------------"
    echo "Top 5 Processes by Memory Usage:"
    get_top_disk_processes
    echo "-------------------------------"
    echo "OS Version:"
    get_os_version
    echo "-------------------------------"
    echo "Uptime:"
    get_uptime
    echo "-------------------------------"
    echo "Load Average:"
    get_load_average
    echo "-------------------------------"
    echo "Logged In Users:"
    get_logged_in_users
    echo "-------------------------------"  
    echo "Failed Login Attempts:"
    get_failed_login_attempts
    echo "==================================="
}
main 