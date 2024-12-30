#!/bin/bash

# Exit immediately if a command exits with a non-zero status,
# if an undefined variable is used, or if a pipe command fails
set -euo pipefail

# Ensure the script is run as root
if [[ $EUID -ne 0 ]]; then
    echo "Error: This script must be run as root/sudo" >&2
    exit 1
fi



# -----------------------------
# Configuration
# -----------------------------

readonly BACKGROUND_APPS=(
    "Activity Monitor" "Photos" "iTunes" "System Settings" "Calendar"
    "Reminders" "Notes" "Maps" "Contacts" "Messages" "FaceTime"
    "App Store" "Xcode" "Visual Studio Code" "Github Desktop" "Slack"
    "SF Symbols" "Mail" "Java" "Roblox" "Home" "Finder"
    "Automator" "Books" "Calculator" "Chess" "Clock" "Dictionary"
    "Epic Games Launcher" "Find My" "Font Book" "Freeform"
    "Image Capture" "Image Playground" "iPhone Mirroring" "Mactracker"
    "Microsoft Excel" "Microsoft OneNote" "Microsoft Outlook"
    "Microsoft PowerPoint" "Microsoft Word" "Mythic" "News"
    "OneDrive" "Passwords" "Podcasts" "Photo Booth" "Preview"
    "QuickTime Player" "Shortcuts" "Stickies" "Stocks" "TextEdit"
    "The Unarchiver" "TV" "Tips" "Time Machine"
    "Unzip - RAR ZIP 7Z Unarchiver" "Voice Memos" "Weather"
    "Siri" "Mission Control"
)
# Add other apps you don’t use while playing to the list above



# -----------------------------
# Helper Functions
# -----------------------------

# Helper function to log messages with timestamps
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

# clean up background processes
cleanup_background_processes() {
    log "Stopping background processes..."
    for app in "${BACKGROUND_APPS[@]}"; do
        if pgrep "$app" >/dev/null 2>&1; then
            pkill "$app" >/dev/null 2>&1 || log "Warning: Failed to stop $app"
        fi
    done
}

# Clear system caches
clear_system_caches() {
    log "Clearing system caches..."
    # Clear system memory cache
    purge || log "Warning: Failed to clear memory cache"
    
    # Clear dynamic library cache
    update_dyld_shared_cache || log "Warning: Failed to update dyld shared cache"
    
    # Clear DNS cache and restart service
    dscacheutil -flushcache
    killall -HUP mDNSResponder >/dev/null 2>&1 || log "Warning: Failed to restart DNS service"
}

# Optimize system settings
optimize_system_settings() {
    log "Optimizing system settings..."
    
    # Set memory purge settings
    sysctl kern.memorystatus_purge_on_urgent=1 || log "Warning: Failed to set memory purge settings"
    
    # Disable hibernation
    pmset -a hibernatemode 0 || log "Warning: Failed to disable hibernation"
}

# Optimize Roblox process priority
optimize_roblox_process() {
    log "Optimizing Roblox process priority..."
    local roblox_pid
    
    if roblox_pid=$(pgrep RobloxPlayer 2>/dev/null); then
        renice -n -10 -p "$roblox_pid" || log "Warning: Failed to adjust Roblox process priority"
    else
        log "Note: Roblox process not found, skipping priority adjustment"
    fi
}

# Launch Roblox
launch_roblox() {
    log "Launching Roblox..."
    if ! open -a Roblox; then
        log "Error: Failed to launch Roblox"
        return 1
    fi
}



# -----------------------------
# Main Execution
# -----------------------------

# Main function to execute all optimizations
main() {
    log "Starting Roblox performance optimization..."
    
    cleanup_background_processes                # Stop background processes
    clear_system_caches                         # Clear system caches
    optimize_system_settings                    # Optimize system settings
    launch_roblox                               # Launch Roblox
    optimize_roblox_process                     # Optimize Roblox process priority
    
    log "Performance optimizations completed successfully"
    pkill Terminal >/dev/null 2>&1              # Close Terminal window
}

# Execute main function
main "$@"
