# This script applies performance optimizations specifically to roblox
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
pkill "Java"                                                                # Java - unnecessary if you wanna play Roblox



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

# Enable fast memory compression for more efficient memory use (improves performance under memory pressure)
sudo sysctl vm.compressor_mode=4                                            # Safe, adjusts the memory compression mode to a faster one

# Aggressively purge memory when under heavy memory pressure
sudo sysctl kern.memorystatus_purge_on_urgent=1                             # Safe, this forces memory purging when under memory pressure

# Clear DNS cache to avoid any potential network resolution issues
sudo dscacheutil -flushcache                                                # Safe, clears DNS cache

# Restart the DNS service to refresh DNS settings
sudo killall -HUP mDNSResponder                                             # Safe, restarts mDNSResponder for network name resolution



# -------------------------------
# Launch Roblox
# -------------------------------

# Open Roblox (will launch the Roblox app)
open -a Roblox  # Safe, launches the Roblox application



# -------------------------------
# Disable hibernation (optional for performance)
# -------------------------------

# Disables hibernation to prevent the system from writing memory to disk (saves time during startup)
sudo pmset -a hibernatemode 0                                               # Safe, but disables sleep to disk, so you’ll lose the ability to resume from hibernation.



# -------------------------------
# Set Roblox process priority (if running)
# -------------------------------

# Increase the priority of the Roblox process to allocate more CPU resources to it
if pgrep RobloxPlayer > /dev/null; then
    renice -n -10 -p $(pgrep RobloxPlayer)                                  # Safe, sets the priority of the Roblox process to a higher level
fi



# -------------------------------
# Final message
# -------------------------------

# Print message to console letting user know that performance optimizations have been applied
echo "Performance optimizations applied to run Roblox."