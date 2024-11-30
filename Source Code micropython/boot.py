import machine
import time

# Optional: Wait a short time to give an opportunity to halt the execution if needed
for i in range(3, 0, -1):
    print(f"Starting in {i} seconds... Press CTRL+C to stop.")
    time.sleep(1)

# Start the main program
try:
    import main
except ImportError:
    print("Failed to start main program. Ensure main.py is present.")
