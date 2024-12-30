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
)   # Add other apps you don’t use while playing to the list above

SKIP_JVM_ARGS=false
SKIP_SETTINGS=false

# Get CPU architecture
ARCH=$(uname -m)

# Get number of CPU cores
CORES=$(sysctl -n hw.ncpu)

# Get GPU information
GPU=$(system_profiler SPDisplaysDataType | grep "Chipset Model" | awk -F: '{print $2}' | sed 's/^ *//')

# Get RAM size in GB
RAM=$(sysctl -n hw.memsize)
RAM=$((RAM / 1024 / 1024 / 1024))  # Convert bytes to GB



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

# Find and open SKLauncher location
find_sklauncher() {
    log "Searching for SKLauncher..."
    
    # Common locations to search
    local search_locations=(
        "$HOME/Downloads"
        "$HOME/Desktop"
        "$HOME/Applications"
        "/Applications"
        "$HOME"
    )
    
    local sklauncher_path=""
    
    # Search for SKLauncher in common locations
    for location in "${search_locations[@]}"; do
        if [ -f "$location/SKlauncher-3.2.10.jar" ]; then
            sklauncher_path="$location/SKlauncher-3.2.10.jar"
            break
        fi
    done
    
    if [ -n "$sklauncher_path" ]; then
        log "SKLauncher found at: $sklauncher_path"
        open -R "$sklauncher_path"  # Open in Finder
        return 0
    else
        log "Error: SKLauncher-3.2.10.jar not found in common locations, Please Move SKlauncher to a common location, eg.: $HOME/Downloads"
        return 1
    fi
}

# Generate recommended Video Settings for Minecraft based on system specs
generate_settings() {
    echo
    log "Generating recommended Video Settings for Minecraft..."
    echo "This is an experimental feature but might increase or decrease performance"
    echo "============================================"

    local settings=""
    # Base low-end settings
    local base_settings="Graphics: Fast, Biome Blend: OFF, VSync: ON, Clouds: OFF, Entity Shadows: OFF, Minimap Levels: OFF, Menu Background Blur: OFF, Smooth Lighting: OFF, Particles: Minimal, Render Distance: 8, Simulation Distance: 8"

    if [[ "$ARCH" == "arm64" ]]; then
        if [[ "$GPU" == *"Apple"* ]]; then
            if [[ "$GPU" == *"M1"* ]]; then
                settings="Graphics: Fast, Biome Blend: OFF, VSync: ON, Clouds: Fast, Entity Shadows: OFF, Menu Background Blur: OFF, Smooth Lighting: ON, Particles: Minimal, Render Distance: 16-12, Simulation Distance: 12-8, Fog: ON"
            elif [[ "$GPU" == *"M2"* ]]; then
                settings="Graphics: Fancy, Biome Blend: 5x5, VSync: ON, Clouds: Fast, Entity Shadows: ON, Menu Background Blur: OFF, Smooth Lighting: ON, Particles: Decreased, Render Distance: 20-16, Simulation Distance: 16-12, Fog: ON"
            elif [[ "$GPU" == *"M3"* ]]; then
                settings="Graphics: Fancy, Biome Blend: 7x7, VSync: ON, Clouds: Fancy, Entity Shadows: ON, Menu Background Blur: ON, Smooth Lighting: ON, Particles: All/Decresead, Render Distance: 24-20, Simulation Distance: 20-16, Fog: ON"
            elif [[ "$GPU" == *"M4"* ]]; then
                settings="Graphics: Fancy, Biome Blend: 9x9, VSync: ON, Clouds: Fancy, Entity Shadows: ON, Menu Background Blur: ON, Smooth Lighting: Maximum, Particles: All, Render Distance: 32-24, Simulation Distance: 32-20, Fog: ON"
            else
                settings="$base_settings"
            fi
        fi
    elif [[ "$ARCH" == "x86_64" ]]; then
        if [[ "$GPU" == *"Intel"* ]]; then
            settings="$base_settings"
        elif [[ "$GPU" == *"NVIDIA"* || "$GPU" == *"AMD"* ]]; then
            if (( RAM >= 32 )); then
                settings="Graphics: Fancy, Biome Blend: 7x7, VSync: ON, Clouds: Fancy, Entity Shadows: ON, Menu Background Blur: ON, Smooth Lighting: Maximum, Particles: All, Render Distance: 24, Simulation Distance: 20, Fog: ON"
            elif (( RAM >= 16 )); then
                settings="Graphics: Fancy, Biome Blend: 5x5, VSync: ON, Clouds: Fast, Entity Shadows: ON, Menu Background Blur: OFF, Smooth Lighting: Maximum, Particles: All, Render Distance: 16, Simulation Distance: 12, Fog: ON"
            else
                settings="$base_settings"
            fi
        else
            settings="$base_settings"
        fi
    else
        settings="$base_settings"
    fi

    echo "=== Recommended Video Settings ==="
    echo "$settings"
    echo "============================================"
}


# Generate JVM arguments based on system specs
generate_jvm_arguments() {
    printf "\n\n"
    log "Generating JVM arguments for Minecraft..."
    echo "============================================"

    local min_ram                               # Local min_ram
    local max_ram                               # Local max_ram

    if (( RAM < 16 )); then
        min_ram=$((RAM / 4))                    # 25% of total RAM
        max_ram=$((RAM / 2))                    # 50% of total RAM
    elif (( RAM >= 16 && RAM <= 32 )); then
        min_ram=8                               # Start with 8GB for larger systems
        max_ram=$((RAM * 3 / 4))                # 75% of total RAM
        (( max_ram > 16 )) && max_ram=16        # Cap at 16GB
    else
        min_ram=8
        max_ram=24                              # Cap high-RAM systems at 24GB
    fi

    (( min_ram < 1 )) && min_ram=1              # Ensure at least 1GB minimum
    
    # Set ParallelGCThreads based on core count
    local gc_threads=$((CORES > 4 ? 4 : CORES)) # Use up to 4 threads for GC

    # Generate JVM arguments
    local jvm_args="-Xms${min_ram}G -Xmx${max_ram}G -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC \
-XX:G1NewSizePercent=20 -XX:G1ReservePercent=20 -XX:MaxGCPauseMillis=50 \
-XX:ParallelGCThreads=${gc_threads} -Dsun.rmi.dgc.server.gcInterval=2147483646"

    # Output JVM arguments
    echo
    echo "=== JVM Recommended Arguments ==="
    echo "$jvm_args"
    echo "============================================"
}



# -----------------------------
# Main Execution
# -----------------------------

# Main function to execute all optimizations
main() {
    # Parse command line arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            --skip-jvm)
                SKIP_JVM_ARGS=true
                shift
                ;;
            --skip-settings)
                SKIP_SETTINGS=true
                shift
                ;;
            *)
                shift
                ;;
        esac
    done

    log "Starting SKLauncher performance optimization..."
    
    cleanup_background_processes
    clear_system_caches
    optimize_system_settings
    find_sklauncher
    
    if [ "$SKIP_SETTINGS" = false ]; then
        generate_settings
    fi
    
    if [ "$SKIP_JVM_ARGS" = false ]; then
        generate_jvm_arguments
    fi
    
    printf "\n"
    log "Performance optimizations completed successfully"
    
    printf "\n"
    echo "You can Now close this terminal window"
}

# Execute main function
main "$@"