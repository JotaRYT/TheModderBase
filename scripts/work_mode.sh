#!/bin/bash

# Exit immediately if a command exits with a non-zero status,
# if an undefined variable is used, or if a pipe command fails
set -euo pipefail

# Ensure the script is run as root
if [[ $EUID -ne 0 ]]; then
    echo "Error: This script must be run as root/sudo and to make sure all settings are reverted, disable SIP temporary." >&2
    exit 1
fi

# -----------------------------
# Configuration
# -----------------------------

# List of apps to close before starting work
readonly CLOSE_APPS=(
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
)   # Add other apps if needed


# Open the apps you usually use while working
readonly OPEN_APPS=(
    "Visual Studio Code" "Terminal" "Mail" "Messages" "Calendar" 
    "Reminders" "Notes" "SF Symbols" "Xcode"
)   # Add the apps you usually use while working



# -----------------------------
# Helper Functions
# -----------------------------

# Helper function to log messages with timestamps
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

# clean up unnecessary processes for work
cleanup_background_processes() {
    log "Stopping background processes..."
    for app in "${CLOSE_APPS[@]}"; do
        if pgrep "$app" >/dev/null 2>&1; then
            pkill "$app" >/dev/null 2>&1 || log "Warning: Failed to stop $app"
        fi
    done
}

# open up apps for work
open_work_processes() {
    log "Opening work apps..."
    for app in "${OPEN_APPS[@]}"; do
        open -a "$app" || log "Warning: Failed to open $app"
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

# Revert system settings to work
optimize_system_settings() {
    log "Reverting system settings..."
    
    # Set memory purge settings
    sysctl kern.memorystatus_purge_on_urgent=5 || log "Warning: Failed to set memory purge settings"
    
    # Disable hibernation
    pmset -a hibernatemode 3 || log "Warning: Failed to enable hibernation"
}

# Optimize battery life
optimize_battery_life() {
    log "Optimizing system for battery life..."

    # Enable automatic graphics switching (use integrated graphics)
    pmset -a gpuswitch 2 || log "Warning: Failed to enable automatic graphics switching"

    # Set Energy Saver settings
    pmset -b displaysleep 2 disksleep 10 sleep 20 || log "Warning: Failed to set Energy Saver settings"
    
    # Enable power nap for better background efficiency
    pmset -b powernap 1 || log "Warning: Failed to enable power nap"
    
    # Reduce spotlight indexing frequency
    mdutil -a -i off || log "Warning: Failed to disable spotlight indexing for battery"
    
    # Enable battery conservation mode
    pmset -a lowpowermode 1 || log "Warning: Failed to enable low power mode"
    
    log "Battery life optimization complete!"
}


# -----------------------------
# Main Script Execution
# -----------------------------

log "Starting system optimization for work mode..."

cleanup_background_processes
clear_system_caches
optimize_system_settings
optimize_battery_life
open_work_processes

log "System optimization for work mode complete!"
