# 4 Monitoring and logging
import psutil

cpu_percent = psutil.cpu_percent(interval=1)
memory_percent = psutil.virtual_memory().percent

print(f"CPU usage: {cpu_percent}%")
print(f"Memory usage: {memory_percent}%")