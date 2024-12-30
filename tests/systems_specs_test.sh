#!/bin/bash

# Get CPU architecture
ARCH=$(uname -m)

# Get number of CPU cores
CORES=$(sysctl -n hw.ncpu)

# Get macOS version
MACOS_VERSION=$(sw_vers -productVersion)

# Get GPU information
GPU=$(system_profiler SPDisplaysDataType | grep "Chipset Model" | awk -F: '{print $2}' | sed 's/^ *//')

# Get RAM size in GB
RAM=$(sysctl -n hw.memsize)
RAM=$((RAM / 1024 / 1024 / 1024))  # Convert bytes to GB

# Function to display recommendations based on specs
display_recommendations() {
    echo "=== System Recommendations ==="
    if [[ "$ARCH" == "arm64" ]]; then
        echo "- You're running an ARM64 architecture (Apple Silicon)."
        echo "- Recommended software: Use native ARM64 apps for best performance (e.g., Homebrew for ARM64)."
    elif [[ "$ARCH" == "x86_64" ]]; then
        echo "- You're running an Intel architecture."
        echo "- Recommended software: Compatible with x86_64 apps."
    else
        echo "- Unknown architecture: $ARCH"
    fi

    if (( CORES <= 4 )); then
        echo "- Low core count detected ($CORES cores). Suitable for light tasks."
    elif (( CORES > 4 && CORES <= 8 )); then
        echo "- Medium core count detected ($CORES cores). Suitable for moderate multitasking."
    else
        echo "- High core count detected ($CORES cores). Suitable for heavy workloads like video editing or gaming."
    fi

    if (( RAM <= 8 )); then
        echo "- Low RAM detected (${RAM}GB). Consider upgrading for better multitasking."
    elif (( RAM > 8 && RAM <= 16 )); then
        echo "- Moderate RAM detected (${RAM}GB). Suitable for most tasks."
    else
        echo "- High RAM detected (${RAM}GB). Great for demanding applications."
    fi

    echo "- GPU: $GPU. Ensure driver compatibility for optimal performance."
    echo "- macOS Version: $MACOS_VERSION. Ensure compatibility with your applications."
    
}

# Display system information
echo "=== System Information ==="
echo "CPU Architecture: $ARCH"
echo "CPU Cores: $CORES"
echo "RAM: ${RAM}GB"
echo "GPU: $GPU"
echo "macOS Version: $MACOS_VERSION"

# Display recommendations
display_recommendations
