# PwrOpt
Maximize battery life and efficiency on Fedora, This script automates the installation and configuration of TLP and Powertop, safely handling conflicts with default power services. Includes a simple utility to fully restore all default settings.

#  PwrOpt: Fedora Power Optimization Scripts 

**PwrOpt** is interactive Bash scripts designed to maximize battery life on **Fedora**. It automates the installation and configuration of  **TLP** and **Powertop**.

##  Key Features

  * **Maximized Endurance:** Installs and configures **TLP** , background power-saving policies.
  * **Conflict-Free Setup:** Safely disables default `power-profiles-daemon` to ensure TLP has uninterrupted control.
  * **Optional Powertop:** Offers to install **Powertop** for live power diagnostics and sets up a systemd service for automatic auto-tuning on every boot.
  * **Custom Control:** Prompts you to manage services like `thermald` which can interfere with TLP's performance policies.
  * **Full Reversibility:** Includes the **PwrOpt-Restore** to safely revert all changes.

-----

##  Usage: Power Optimization Script

### 1\. Download

Clone the repository or download the scripts:

```bash
# Clone the repository
git clone https://github.com/hasanuzzamanmir/PwrOpt.git
cd PwrOpt
```

### 2\. Run the Optimizer

Execute the main setup script. **Administrative privileges (sudo) will be required.**

```bash
chmod +x power_optimizer.sh
./power_optimizer.sh
```

**Follow the on-screen prompts** to make your selections for Powertop and thermald.

-----

##  Reverting Changes: PwrOpt-Restore Utility

If you need to revert to Fedora's default power configuration, use the restoration script.

### 1\. Run the Restore Script

```bash
chmod +x power_rest.sh
./power_rest.sh
```

**Follow the prompts.** The script will safely:

  * **Remove TLP** and its associated configuration.
  * **Re-enable** the `power-profiles-daemon`.
  * **Re-enable `thermald`**.
  * Optionally **remove Powertop** and clean up its auto-tune service.

-----

##  Configuration Summary

| Tool | Purpose | Status After Setup | Restoration Status |
| :--- | :--- | :--- | :--- |
| **TLP** | Background Power Management | **Enabled** | **Removed** |
| **Powertop** | Diagnostics & Auto-Tuning | **Optional** (User Choice) | **Optional** (User Choice to Remove) |
| `power-profiles-daemon` | Fedora Default Power Service | **Disabled/Masked** | **Unmasked/Enabled** |
| `thermald` | CPU Thermal Control | **Optional** (User Choice) | **Enabled** |

-----

##  Contribution

Contributions are welcome\! Feel free to open an issue or submit a Pull Request for new features, bug fixes, or improved configurations.
