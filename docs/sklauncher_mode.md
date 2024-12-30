# SKLauncher Mode - Performance Optimization Script

## Overview

The SKLauncher Mode script provides system optimization for running Minecraft on macOS through SKLauncher. It automatically adjusts settings, clears caches, and generates optimal configurations based on your hardware specifications.

## Compatibility

- **Operating System**: macOS 15.x
- **Architecture**: Intel (x86_64) and Apple Silicon (arm64)
- **Required Software**:
  - SKLauncher (version 3.2.10)
  - Java/JDK (Latest LTS recommended and JDK over Java)

## Features

- Automatic hardware detection and optimization
- Smart background process management
- Dynamic JVM arguments generation
- Recommended video settings based on GPU
- System cache cleanup
- Temporary performance tweaks

## Usage

### Basic Usage

```bash
sudo ./sklauncher_mode.sh
```

### Advanced Options

```bash
sudo ./sklauncher_mode.sh [options]

Options:
  --skip-jvm       Skip JVM arguments generation
  --skip-settings  Skip video settings recommendations
```

## Hardware-Specific Optimizations

### Apple Silicon (M-series)

- M1: Balanced settings for efficiency and performance
- M2: Enhanced graphics and render distance
- M3/M4: Maximum quality settings with extended view distance

### Intel-based Macs

- Integrated Graphics: Conservative settings for stability
- Discrete GPU: Enhanced settings based on available RAM

## Generated Configurations

### JVM Arguments

- Dynamically allocated based on system RAM
- Optimized garbage collection settings
- Hardware-specific threading configurations

### Video Settings

- GPU-aware graphics presets
- Balanced performance vs. quality options
- RAM-dependent render distance adjustments

## Background Process Management

The script manages these application categories:

- System utilities (Activity Monitor, System Settings)
- Media apps (Photos, Music, TV)
- Communication apps (Messages, FaceTime)
- Development tools (Xcode, VS Code)
- Office applications
- Gaming platforms

## Safety Features

- Automatic SKLauncher detection
- Error handling for missing components
- Safe process termination
- Temporary system modifications
- No permanent changes to system configuration

## Troubleshooting

### Common Issues

1. **SKLauncher Not Found**
   - Ensure SKLauncher-3.2.10.jar is in a supported location
   - Supported paths: Downloads, Desktop, Applications

2. **Permission Errors**
   - Run with sudo
   - Verify file permissions

3. **Performance Issues**
   - Check generated settings match your hardware
   - Monitor system resources
   - Consider using --skip-settings for manual configuration
   - Don't blame an experimental feature, generation of JVM Arguments & Minecraft settings is just experimental and might be correct/incorrect.

## Best Practices

1. Keep macOS and Java/JDK updated
2. Open issues with JVM & Minecraft settings generation if found any.

## Additional Notes

- Video settings are recommendations only
- JVM arguments require manual application in SKLauncher, you can do this in profile->edit installation->advanced options/settings-> Arguments(the end of the page)
- The script prioritizes stability over maximum performance so it might give you 120 stable FPS or 60 locked FPS.

## Technical Details

The script performs these operations:

1. **System Analysis**
   - CPU architecture detection
   - RAM availability check
   - GPU identification
   - Core count determination

2. **Resource Management**
   - Memory cache clearing
   - Dynamic library cache updates
   - DNS cache management
   - Process priority adjustment

3. **Configuration Generation**
   - Hardware-specific JVM arguments
   - Optimized video settings
   - Memory allocation calculations
