#!/bin/bash

# Get top CPU process with detailed information
top_proc=$(ps -eo %cpu,%mem,pid,etime,comm,args --sort=-%cpu --no-headers | head -1)

# Parse the output
cpu=$(echo "$top_proc" | awk '{print $1}')
mem=$(echo "$top_proc" | awk '{print $2}')
pid=$(echo "$top_proc" | awk '{print $3}')
time=$(echo "$top_proc" | awk '{print $4}')
cmd=$(echo "$top_proc" | awk '{print $5}')
args=$(echo "$top_proc" | awk '{for(i=6;i<=NF;i++) printf "%s ", $i}' | sed 's/ $//')

# Create JSON output for waybar
printf '{"text":"%.1f%% %.1f%% %s", "tooltip":"Top CPU Process:\\nPID: %s\\nCPU: %.1f%%\\nMemory: %.1f%%\\nRuntime: %s\\nCommand: %s\\nArgs: %s"}' \
    "$cpu" "$mem" "$(echo $cmd | cut -c1-8)" "$pid" "$cpu" "$mem" "$time" "$cmd" "$args"