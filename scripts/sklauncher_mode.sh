# This script applies performance optimizations specifically to SKLauncher (Minecraft Launcher)
# Sudo is required to run this script.



# -------------------------------
# Introduction
# -------------------------------

# Print message to console letting user know that performance optimizations are being applied
echo "Performance optimizations are being applied to run SKLauncher..."



# -------------------------------
# Stop unnecessary background processes
# -------------------------------

# Kill various background processes that may consume resources unnecessarily
# These apps will be terminated to free up system resources.
pkill "Activity Monitor"                                                    # Activity Monitor - system monitoring tool
pkill "Photos"                                                              # Photos app - consuming resources with media library
pkill "iTunes"                                                              # iTunes - legacy app, replaced by Music on newer macOS versions
pkill "Music"                                                               # Music app - could be running in the background
pkill "System Settings"                                                     # System Settings - not needed while gaming
pkill "Calendar"                                                            # Calendar app - unnecessary in a gaming context
pkill "Reminders"                                                           # Reminders app - background task
pkill "Notes"                                                               # Notes app - may use resources for syncing
pkill "Maps"                                                                # Maps app - consumes resources even when not in use
pkill "Contacts"                                                            # Contacts app - syncing in the background
pkill "Messages"                                                            # Messages app - consumes CPU for notifications
pkill "FaceTime"                                                            # FaceTime app - will impact performance
pkill "App Store"                                                           # App Store - unnecessary during gameplay
pkill "Xcode"                                                               # Xcode - developer tool, not needed during gaming
pkill "Visual Studio Code"                                                  # Visual Studio Code - developer tool
pkill "Github Desktop"                                                      # GitHub Desktop - unnecessary in gaming mode
pkill "Slack"                                                               # Slack - messaging app that may use CPU
pkill "SF Symbols"                                                          # SF Symbols - design tool running in the background
pkill "Mail"                                                                # Mail app - unnecessary background activity
pkill "Roblox"                                                              # Roblox - unnecessary if you wanna play Minecraft



# -------------------------------
# Clear system caches
# -------------------------------

# Clear system memory cache to free up RAM (may improve performance)
sudo purge                                                                  # This clears system memory cache (RAM) - Safe to use, but can slow things down temporarily.

# Clear system shared dynamic libraries cache (rebuilds on next boot)
sudo update_dyld_shared_cache                                               # Clears the dynamic library cache - Safe to use



# -------------------------------
# Adjust memory and system settings
# -------------------------------

# Reset VM-related Sysctl Parameters
sudo sysctl vm.swapusage                                                    # Safe, displays swap usage
sudo sysctl kern.maxvnodes                                                  # Safe, displays max vnodes

# Aggressively purge memory when under heavy memory pressure
sudo sysctl kern.memorystatus_purge_on_urgent=1                             # Safe, this forces memory purging when under memory pressure

# Clear DNS cache to avoid any potential network resolution issues
sudo dscacheutil -flushcache                                                # Safe, clears DNS cache

# Restart the DNS service to refresh DNS settings
sudo killall -HUP mDNSResponder                                             # Safe, restarts mDNSResponder for network name resolution



# -------------------------------
# Minecraft Tweaks
# -------------------------------

-Dfml.readTimeout=60                                                        # Safe, sets the read timeout for Forge Mod Loader to 60 seconds



# -------------------------------
# Launch SKLauncher
# -------------------------------

# Function to find SKLauncher dynamically
find_SKlauncher() {
    # Search in /Applications and ~/Downloads for files matching "SKlauncher-*.jar"
    local SKlauncher_path
    SKlauncher_path=$(find /Applications ~/Downloads -maxdepth 1 -iname "SKlauncher-*.jar" | head -n 1)
    
    # Check if SKLauncher was found
    if [ -n "$SKlauncher_path" ]; then
        echo "$SKlauncher_path"
    else
        echo ""
    fi
}

# Find SKLauncher
SKlauncher=$(find_SKlauncher)

# Check if SKLauncher was found
if [ -n "$SKlauncher" ]; then
    echo "Launching SKLauncher from: $SKlauncher"
    # Use Java to run the JAR file
    java -jar "$SKlauncher"
else
    echo "SKLauncher not found in Applications or Downloads. Please ensure it is installed."
    exit 1
fi



# -------------------------------
# Alocate Resources to Java
# -------------------------------

-XX:+UnlockExperimentalVMOptions                                            # Safe, unlocks experimental VM options for Java
-XX:+AlwaysPreTouch                                                         # Safe, pre-touches memory to avoid lazy memory allocation(aggressive heap management)
-Xms2G -Xmx8G                                                               # Safe, allocates initial 2GB of memory to Java and allows it to use up to 8GB of memory(change this if you have more RAM)
-XX:+UseG1GC                                                                # Safe, enables the G1 garbage collector to optimize performance
-XX:MaxGCPauseMillis=50                                                     # Safe, sets the maximum pause time goal for garbage collection to 50 milliseconds
-XX:+UseParallelGC                                                          # Safe, enables parallel garbage collection to make better use of multi-core CPUs.
-XX:ParallelGCThreads=4                                                     # Safe, but can either improve performance or make it worse. Sets the number of threads used for parallel garbage collection(changing this if you have more cores)
-XX:+AggressiveOpts                                                         # Safe, enables aggressive optimizations for better performance
-Dsun.java2d.opengl=true                                                    # Safe, enables OpenGL acceleration for Java2D rendering(Good for minecraft)
-Xss256k                                                                    # Safe, sets the thread stack size to 256KB
-XX:+UseConcMarkSweepGC                                                     # Safe, enables the Concurrent Mark Sweep garbage collector



# -------------------------------
# JVM good Arguments
# -------------------------------

-XX:+DisableExplicitGC                                                      # Safe, disables explicit garbage collection calls
-Xshare:on                                                                  # Safe, enables class data sharing to reduce startup time
-XX:+UseStringDeduplication                                                 # Safe, enables string deduplication to reduce memory usage



# -------------------------------
# Final message
# -------------------------------

# Print message to console letting user know that performance optimizations have been applied
echo "Performance optimizations applied to run Minecraft using SKLauncher.."