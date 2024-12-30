# Work Mode - System Optimization Script

## Overview

The Work Mode script prepares your macOS environment for productive work sessions by managing applications, system resources, and power settings. It's designed to create an optimal working environment while maximizing battery life and reverting all gaming settings

## Compatibility

- **Operating System**: macOS 15.x or later
- **Architecture Support**: Intel and Apple Silicon
- **Requirements**: Administrator privileges

## Features

- Smart application management
- System resource optimization
- Battery life optimization
- Workspace environment setup
- Custom application configurations

## Usage

### Basic Command

```bash
sudo ./work_mode.sh
```

## System Optimizations

### Application Management

- Closes non-work applications
- Launches work-specific applications
- Manages background services

### Power Management

- Battery life optimization
- Display energy settings
- Process scheduling
- Automatic graphics switching

### System Resources

- Cache management
- Memory optimization
- Background service control
- Spotlight indexing adjustment

## Customization

### Work Applications

Edit the `OPEN_APPS` array in the script to include your preferred work applications:

```bash
readonly OPEN_APPS=(
    "Visual Studio Code"
    "Terminal"
    "Mail"
    # Add your work apps here
)
```

### Background Applications

Modify the `CLOSE_APPS` array to specify which applications should be closed:

```bash
readonly CLOSE_APPS=(
    "Roblox"
    "TV"
    # Add apps to close here
)
```

## Best Practices

1. Configure your work applications list before first use
2. Run at the start of work sessions
3. Keep macOS updated

## Troubleshooting

### Common Issues

1. **Permission Errors**
   - Run with sudo
   - Check SIP status, recommended disabling SIP temporary then re-enabling it
   - Verify file permissions

2. **Application Issues**
   - Verify application paths
   - Check application names
   - Ensure applications are installed

3. **Performance Issues**
   - Monitor system resources
   - Check background processes
   - Verify power settings

## Technical Details

The script performs these operations:

1. **Environment Setup**
   - Application launch/closure
   - System cache clearing
   - Power optimization

2. **Resource Management**
   - Memory optimization
   - Process priority adjustment
   - Background service control

3. **Power Settings**
   - Display sleep configuration
   - GPU management
   - Battery conservation

## Safety Features

- Non-destructive operations
- Reversible system changes
- Safe application handling
- Error logging and reporting
