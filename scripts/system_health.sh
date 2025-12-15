#!/bin/bash

LOG_FILE="system_health.log"

CPU_THRESHOLD=80
MEM_THRESHOLD=80
DISK_THRESHOLD=80

echo "===== System Health Check: $(date) =====" | tee -a $LOG_FILE

# CPU usage
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
CPU_USAGE=${CPU_USAGE%.*}

if [ "$CPU_USAGE" -gt "$CPU_THRESHOLD" ]; then
  echo "ALERT: High CPU usage: $CPU_USAGE%" | tee -a $LOG_FILE
else
  echo "CPU usage OK: $CPU_USAGE%" | tee -a $LOG_FILE
fi

# Memory usage
MEM_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
MEM_USAGE=${MEM_USAGE%.*}

if [ "$MEM_USAGE" -gt "$MEM_THRESHOLD" ]; then
  echo "ALERT: High Memory usage: $MEM_USAGE%" | tee -a $LOG_FILE
else
  echo "Memory usage OK: $MEM_USAGE%" | tee -a $LOG_FILE
fi

# Disk usage
DISK_USAGE=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')

if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]; then
  echo "ALERT: High Disk usage: $DISK_USAGE%" | tee -a $LOG_FILE
else
  echo "Disk usage OK: $DISK_USAGE%" | tee -a $LOG_FILE
fi

# Running processes
PROCESS_COUNT=$(ps -e --no-headers | wc -l)
echo "Running processes: $PROCESS_COUNT" | tee -a $LOG_FILE

echo "=========================================" | tee -a $LOG_FILE

