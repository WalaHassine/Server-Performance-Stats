# Total CPU usage
echo "===== Server Performance Stats ====="
echo "-------------------------------"
echo "Total CPU Usage:" 
top -bn1 | grep "Cpu(s)" | \
sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | \
awk '{print 100 - $1"%"}'
echo "-------------------------------"

# Total memory usage (Free vs Used including percentage)
echo "Total Memory Usage:"
free -h | grep Mem | awk '{print "Total: " $2 ", Used: " $3 ", Free: " $4 ", Percentage: " $3/$2*100 "%"}'
echo "-------------------------------"

# Total disk usage (Free vs Used including percentage)
echo "Total Disk Usage:"
df -h --total | grep total | awk '{print "Total: " $2 ", Used: " $3 ", Free: " $4 ", Percentage: " $5}'
echo "-------------------------------"

# Top 5 processes by CPU usage
echo "Top 5 Processes by CPU Usage:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
echo "-------------------------------"

# Top 5 processes by memory usage
echo "Top 5 Processes by Memory Usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6
echo "-------------------------------"


# OS version
echo "OS Version:"
uname -r
echo "-------------------------------"

# Uptime
echo "Uptime:"
uptime -p
echo "-------------------------------"

# Load average
echo "Load Average:"
uptime | awk -F'load average:' '{ print $2 }'
echo "-------------------------------"

# Logged in users
echo "Logged In Users:"
who | wc -l
echo "-------------------------------"  

# Failed login attempts 
echo "Failed Login Attempts:"
lastb | wc -l
       
echo "==================================="