# TheModderBase

Welcome to TheModderBase! This repository is dedicated to a Swift app I'm developing, featuring a collection of shell scripts designed to optimize system performance. Whether you want to boost your FPS (performance) or extend your battery life, you've come to the right place.

## Recommendations

- **Always use sudo:** Most of the scripts in this repository require administrative privileges to function correctly. Without sudo, many commands may fail or not execute as intended.

## Disclaimer

> **⚠️ Warning:** I do not take responsibility for any software or hardware issues that may arise from using these scripts. Use them at your own risk.
>
> By utilizing these scripts, you accept full responsibility for any potential problems with your hardware or software. These scripts were made with love and tested on macOS 15.x versions and may not work on older or newer versions of macOS.
> Please proceed with caution and ensure you understand the changes being made to your system.

## License

This project is licensed under the **MIT License**. You are free to use, modify, and distribute this work. If you make modifications or publish derivatives, proper attribution is required.

## FAQ

### Q: Why can't I run the scripts in the terminal?

**A:** Ensure you are using the correct syntax AND with administrative privileges:

```bash
sudo ./script_name.sh
```

### Q: I ran sudo ./script_name.sh, but it didn't work or showed an error

**A:** First, try running the script without sudo and then run with sudo.

```bash
./script_name.sh
```

```bash
sudo ./script_name.sh
```

If the problem persists, it's possible that a specific command within the script is incompatible with your macOS version or requires you to disable SIP(tho not recommended).

### Q: Some commands don't work and show "permission denied" or "read-only" errors

**A:** This occurs due to macOS's System Integrity Protection (SIP). While disabling SIP may resolve these issues, it is not recommended by either Apple or myself due to the security risks involved. If you choose to disable SIP, ensure you understand the risks and proceed cautiously.

### Q: Can I create an app using your scripts?

**A:** Absolutely! You're welcome to use these scripts in your app. If you modify or publish your app online, please give proper credit to ensure recognition of the original work.

### Q: Does any of those terminal shell scripts collects data?

**A:** No, you're welcome to use these scripts without being tracked and without getting information collected and sent to a server. If you have a lot of concerns, you can check the source-code so yeah, if you don't trust, I can't really do anything.

## Getting Started

Explore the repository and try out the scripts to see how they can optimize your system. If you encounter any issues or have suggestions, feel free to open an issue or contribute to the project!
