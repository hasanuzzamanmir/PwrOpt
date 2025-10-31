# PwrOpt
Maximize battery life and efficiency on Fedora, This script automates the installation and configuration of TLP and Powertop, safely handling conflicts with default power services. Includes a simple utility to fully restore all default settings.

#  PwrOpt: Fedora Power Optimization Scripts 

PwrOpt is a set of simple, interactive Bash scripts for Fedora users who want the longest possible battery life.It automatically installs and sets up.
##  Key Features

  - **Longer Battery Life:** Installs and sets up **TLP** to manage power settings silently in the background.
    
- **Smart Setup:** Automatically turns off Fedora's built-in power service (like `power-profiles-daemon` or `power-tune`) so TLP can work without any problems.
    
- **Optional Power Diagnostics:** You can choose to install **Powertop** for real-time power checks and set it up to auto-tune your system every time it starts.
    
- **Full Control:** The script asks if you want to disable the `thermald` service, which sometimes clashes with TLP.
    
- **Undo Anytime:** A separate **PwrOpt-Restore** script lets you go back to Fedora's original power settings safely and completely.

-----

##  Usage: Power Optimization Script

### 1\. Download

Clone the repository or download the scripts:
```bash
git clone https://github.com/hasanuzzamanmir/PwrOpt.git
cd PwrOpt
```

### 2\. Run the Optimizer

Execute the main setup script. **You will need administrative privileges (sudo).**

```bash
chmod +x power_optimizer.sh
./power_optimizer.sh
```

**Follow the on-screen prompts** to make your selections for Powertop and thermald.

-----

## Go Back to Default: The PwrOpt-Restore Utility

If you ever want to return to Fedora's standard power settings, just run the restore script.

### 1\. Run the Restore Script

```bash
chmod +x power_rest.sh
./power_rest.sh
```

**Follow the prompts.** The script is smart—it checks your Fedora version and does the right thing::

  * It removes TLP and its configuration files.
  * It automatically detects your Fedora version to restore the correct default power service.
    It restores the older power-profiles-daemon for earlier Fedora versions or the newer power-tune service for recent Fedora releases.
  * It re-enables thermald (if it was disabled).
  * You can choose to remove Powertop and its boot service as well.
-----

##  Configuration Summary

| Tool | Purpose | Status After Setup | Restoration Status |
| :--- | :--- | :--- | :--- |
| **TLP** | Background Power Management | **Enabled** | **Removed** |
| **Powertop** | Diagnostics & Auto-Tuning | **Optional** (Your Choice) | Optional (Remove or Keep) |
| Fedora Default Power Service | Default Power Profile Control | **Disabled/Stopped** | **Re-enabled** |
| `thermald` | CPU Thermal Control | **Optional** (Your Choice) | **Re-enabled** |

-----

##  Contribution

Contributions are welcome\! Feel free to open an issue or submit a Pull Request for new features, bug fixes, or improved configurations.
