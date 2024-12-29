# Roblox Mode - Performance Optimization Script Documentation

## Introduction

The **Roblox Mode** performance optimization shell script is designed to improve the performance of macOS >= 15.x when running Roblox. This script works by killing unnecessary background processes, clearing system caches, and adjusting system settings to allocate more resources to Roblox, ensuring smoother gameplay with higher frame rates and responsiveness. The optimizations are temporary, and the script can be run whenever you want to enter "Roblox mode" on your Mac, but keep in mind to not use this shell script every 2 minutes.

## Disclaimer

> **Warning**:  
> I do not take responsibility for any software or hardware problems that may arise from using this or other scripts. Use it at your own risk. By using this or any related shell scripts, you acknowledge that you are accepting full responsibility for your hardware and software, including any potential issues that may result. Proceed with caution and ensure you understand the changes being made to your system. I made those scripts with love and I tested myself but I only tested in MacOs 15.x versions, not older/newer.

## Purpose

The primary goal of this script is to optimize the system by disabling or limiting processes that consume CPU, RAM, and other system resources, which could otherwise slow down Roblox. The script performs the following tasks:

1. Terminates unnecessary background processes.
2. Clears system and DNS caches to free up resources.
3. Adjusts memory compression settings to enhance performance under load.
4. Disables hibernation to speed up system boot time.
5. Prioritizes Roblox for better performance.

## Prerequisites

- **macOS**: This script is designed for macOS =>15.x operating systems.
- **Roblox**: Roblox should be installed and accessible through the default application directory.
- **Administrator Privileges**: You'll need to run the shell script with sudo to work correctly.

### 1. **Message Initialization**

```bash
echo "Performance optimizations are being applied..."
```

This command simply prints a message to the console, informing the user that performance optimizations are being applied.

### 2. **Stop Unnecessary Background Processes**

```bash
pkill "Activity Monitor"
pkill "Photos"
pkill "iTunes"
pkill "Music"
pkill "System Settings"
pkill "Calendar"
pkill "Reminders"
pkill "Notes"
pkill "Maps"
pkill "Contacts"
pkill "Messages"
pkill "FaceTime"
pkill "App Store"
pkill "Xcode"
pkill "Visual Studio Code"
pkill "Github Desktop"
pkill "Slack"
pkill "SF Symbols"
pkill "Mail"
```

These commands terminate applications running in the background that are not necessary for playing Roblox. By closing apps like Slack, Messages, Photos, and more, the system can free up CPU and RAM for Roblox, preventing performance bottlenecks.
If you want any of those apps open, just remove the lines of apps you want to keep open and if you want to add more apps, you can by just doing `pkill [appName]`

### 3. **Clear System Caches**

```bash
sudo purge                      # Clear system memory cache (RAM)
sudo update_dyld_shared_cache   # Clear system cache
```

- **`sudo purge`**: This command clears the system's RAM cache, freeing up memory for active applications like Roblox.
- **`sudo update_dyld_shared_cache`**: This command clears the dynamic library cache, which may help resolve any library issues and ensure that macOS is using up-to-date libraries.

### 4. **Adjust Memory Management Settings**

```bash
sudo sysctl vm.compressor_mode=4                    # Enable fast memory compression
sudo sysctl kern.memorystatus_purge_on_urgent=1     # Purge memory on urgent (under memory pressure)
```

- **`vm.compressor_mode=4`**: This setting enables faster memory compression, improving how memory is managed under heavy load, which is common when running resource-intensive applications like Roblox.
- **`kern.memorystatus_purge_on_urgent=1`**: This forces the system to aggressively free up memory when it is under memory pressure, improving the overall responsiveness of the system.

### 5. **Clear DNS Cache**

```bash
sudo dscacheutil -flushcache        # Clear DNS cache
sudo killall -HUP mDNSResponder     # Restart DNS service
```

- **`sudo dscacheutil -flushcache`**: Clears the DNS cache, ensuring that any outdated or incorrect network addresses are removed.
- **`sudo killall -HUP mDNSResponder`**: Restarts the mDNSResponder service, which is responsible for resolving domain names in the system, helping resolve any network-related issues that could affect Roblox gameplay.

### 6. **Launch Roblox**

```bash
open -a Roblox  # Launch Roblox application
```

This command opens the Roblox application. It ensures that the game is launched after all optimizations are applied.

### 7. **Disable Hibernation**

```bash
sudo pmset -a hibernatemode 0  # Disable hibernation
```

This command disables hibernation, which can make the system wake up faster and avoid writing the memory to disk. By disabling hibernation, the system remains in a fast performance mode, which is beneficial for gaming.

### 8. **Set Roblox Process Priority**

```bash
if pgrep RobloxPlayer > /dev/null; then
    renice -n -10 -p $(pgrep RobloxPlayer)  # Set higher priority for Roblox
fi
```

This checks if Roblox is running, and if so, it increases the process priority, giving Roblox more CPU resources for smoother performance.

### 9. **Final Message**

```bash
echo "Performance optimizations applied."
```

This final message informs the user that the optimizations have been successfully applied, and Roblox is now running in a high-performance environment.

## Usage Instructions

To use the **Roblox Mode** script, follow these steps:

1. Download `roblox_mode.sh`.
2. Open Terminal and navigate to the directory where the script is saved.
3. Make the script executable:

   ```bash
   chmod +x roblox_mode.sh
   ```

4. Run the script:

   ```bash
   sudo ./roblox_mode.sh
   ```

Once the script has finished, Roblox will be running in an optimized environment, and you should notice improved performance during gameplay, this script should stablise FPS.

## Reverting Changes

If you wish to revert the optimizations, you can:

- **Re-enable hibernation**:

  ```bash
  sudo pmset -a hibernatemode 3  # Re-enable hibernation (default setting)
  ```

Or use work_mode.sh which basically open some apps and reset the system to default.

## Conclusion

The **Roblox Mode** script is a simple but effective way to optimize macOS for Roblox by disabling unnecessary processes, freeing up memory, and adjusting system settings. I tried to make the script easy to read and with all information correct, if you have concerns you can search for each command in the internet.

For more information, you can consult Apple's official documentation on `pmset`, `sysctl`, and other system utilities.
