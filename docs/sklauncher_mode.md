# SKLAUNCHER - Minecraft Optimization Script Documentation

## Introduction

The **Minecraft Optimization Script** is designed to improve the performance of macOS systems when running the SKLauncher for Minecraft. The script optimizes the system by killing unnecessary background processes, clearing system caches, and adjusting Java Virtual Machine (JVM) settings for better performance. It ensures that Minecraft runs smoothly with higher frame rates, reduced lag, and optimal use of system resources.

This script is temporary and should be used when preparing to play Minecraft. You can run it every time you want to optimize your system for better gameplay, but frequent use may not be necessary.

## Disclaimer

> **Warning**:  
> I do not take responsibility for any software or hardware problems that may arise from using this or other scripts. Use it at your own risk. By using this or any related shell scripts, you acknowledge that you are accepting full responsibility for your hardware and software, including any potential issues that may result. Proceed with caution and ensure you understand the changes being made to your system. I made those scripts with love and I tested myself but I only tested in MacOs 15.x versions, not older/newer.

## Purpose

The goal of this script is to optimize system performance specifically for running SKLauncher and Minecraft by reducing background tasks, clearing caches, and adjusting system and JVM settings. The script performs the following tasks:

1. Terminates unnecessary background processes to free up system resources.
2. Clears system and DNS caches to improve performance.
3. Adjusts memory and system settings to handle Minecraft more efficiently.
4. Allocates more resources to Java for improved Minecraft performance.
5. Launches SKLauncher and runs Minecraft with optimal settings.

## Prerequisites

- **macOS**: The script is designed for macOS 15.x and later.
- **SKLauncher**: SKLauncher must be installed and accessible on your system.
- **JDK/Java Desktop**: Required to run SKLauncher & Minecraft.
- **Administrator Privileges**: You need sudo privileges to run the script.

## Script Breakdown

### 1. **Message Initialization**

```bash
echo "Performance optimizations are being applied to run SKLauncher..."
```

This prints a message to inform the user that performance optimizations are being applied.

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
pkill "Roblox"
```

These commands terminate applications that are running in the background and not necessary for running Minecraft. Closing apps like Photos, Slack, iTunes, and others frees up CPU and RAM for the game.

### 3. **Clear System Caches**

```bash
sudo purge                      # Clear system memory cache (RAM)
sudo update_dyld_shared_cache   # Clear system cache
```

- **`sudo purge`**: Clears the system's memory cache to free up resources for Minecraft.
- **`sudo update_dyld_shared_cache`**: Clears the dynamic library cache, ensuring macOS is using the most up-to-date libraries.

### 4. **Adjust Memory and System Settings**

```bash
sudo sysctl kern.memorystatus_purge_on_urgent=1       # Purge memory on urgent (under memory pressure)
sudo dscacheutil -flushcache                          # Clear DNS cache
sudo killall -HUP mDNSResponder                       # Restart DNS service
```

- **`kern.memorystatus_purge_on_urgent=1`**: Forces the system to purge memory aggressively under pressure, improving responsiveness.
- **`dscacheutil -flushcache`**: Clears the DNS cache to avoid any potential network issues.
- **`killall -HUP mDNSResponder`**: Restarts the mDNSResponder service for fresh network resolution.

### 5. **Allocate Resources to Java**

```bash
-XX:+UnlockExperimentalVMOptions
-XX:+AlwaysPreTouch
-Xms2G -Xmx8G
-XX:+UseG1GC
-XX:MaxGCPauseMillis=50
-XX:+UseParallelGC
-XX:ParallelGCThreads=4
-XX:+AggressiveOpts
-Dsun.java2d.opengl=true
-Xss256k
-XX:+UseConcMarkSweepGC
```

These are JVM flags that optimize the performance of Minecraft by managing memory and garbage collection more efficiently. They ensure the game uses more memory and runs with smoother graphics.

### 6. **Launch SKLauncher**

```bash
find_SKlauncher() {
    local SKlauncher_path
    SKlauncher_path=$(find /Applications ~/Downloads -maxdepth 1 -iname "SKlauncher-*.jar" | head -n 1)
    
    if [ -n "$SKlauncher_path" ]; then
        echo "$SKlauncher_path"
    else
        echo ""
    fi
}

SKlauncher=$(find_SKlauncher)

if [ -n "$SKlauncher" ]; then
    echo "Launching SKLauncher from: $SKlauncher"
    java -jar "$SKlauncher"
else
    echo "SKLauncher not found in Applications or Downloads. Please ensure it is installed."
    exit 1
fi
```

This section searches for SKLauncher on your system (either in `/Applications` or `~/Downloads`) and launches it using Java. If SKLauncher is not found, an error message is displayed.

### 7. **Final Message**

```bash
echo "Performance optimizations applied to run Minecraft using SKLauncher.."
```

This message informs the user that the optimizations have been applied and SKLauncher is ready to run.

## Usage Instructions

To use the **Minecraft Optimization Script**, follow these steps:

1. Download the script file `minecraft_mode.sh`.
2. Open Terminal and navigate to the directory where the script is saved.
3. Make the script executable:

   ```bash
   chmod +x minecraft_mode.sh
   ```

4. Run the script:

   ```bash
   sudo ./minecraft_mode.sh
   ```

Once the script has finished, SKLauncher will be launched with optimized settings for Minecraft, ensuring better performance during gameplay.

## Reverting Changes

To revert any changes made by the script:

- **Re-enable system features** (like hibernation):

  ```bash
  sudo pmset -a hibernatemode 3  # Re-enable hibernation (default setting)
  ```

Yes, it's just that, JVM arguments stop when you quit an java app.

## Possible Issue: JVM Arguments Not Working in SKLauncher

If you're experiencing issues where the JVM arguments are not being applied while/before running in SKLauncher, you can resolve this by manually adding the arguments to the installation settings. Here's how to fix it:

1. Copy the JVM Arguments: Copy all the required JVM arguments you want to use.
2. Locate the Installation Settings: Go to your installation in SKLauncher and open its settings.
3. Add the Arguments: In the configuration settings, paste the JVM arguments. Make sure to:
   - Place the arguments after any existing ones.
   - Ensure there is a space between the newly added arguments and any that were already there.
   - Check for any duplicate arguments to avoid conflicts.
4. Alternative Solution: If the issue persists, try adding the JVM arguments after launching SKLauncher. This can resolve the issue.

By following these steps, you should be able to apply the JVM arguments successfully.

## Conclusion

The **Minecraft Optimization Script** is an effective way to optimize your macOS system for better Minecraft performance. By disabling unnecessary processes, freeing up system resources, and tweaking JVM settings, this script provides a smooth and lag-free gaming experience. If you have any concerns, you can look up each command used in the script for more details.

For further information, consult Apple's official documentation on system utilities like `sysctl`, `dscacheutil`, and `pmset`.
