#!/bin/bash

echo " Welcome to PowerRest"
echo " Reverting Fedora to its default power management setup..."

# Detect Fedora version
fedora_version=$(rpm -E %fedora)
echo " Detected Fedora version: $fedora_version"
# Check for internet connectivity
if ! ping -q -c 2 -W 2 dl.fedoraproject.org > /dev/null 2>&1; then
    echo " Error: No internet connection."
    echo " Connect to internet and re-run this script."
    exit 1
else
    echo ""
fi
# Remove TLP if installed
echo " To restore,verify it's you "
sudo systemctl disable tlp --now
sudo dnf remove -y tlp tlp-rdw

# Apply default power mngmnt based on Fedora ver
if (( fedora_version < 39 )); then
    echo "Applying default setup for Fedora $fedora_version (older release)..."
    echo "Reason: Fedora versions before 39 use power-profiles-daemon for power management."

    echo "Installing power-profiles-daemon..."
    sudo dnf install -y power-profiles-daemon

    echo "Unmasking and enabling power-profiles-daemon..."
    sudo systemctl unmask power-profiles-daemon
    sudo systemctl enable power-profiles-daemon --now
else
    echo " Applying default setup for Fedora $fedora_version (newer release)..."
    echo " Fedora 39 and newer use tuned as the default power management system."

    echo "Installing tuned and tuned-ppd..."
    sudo dnf install -y tuned tuned-ppd

    echo "Enabling tuned..."
    sudo systemctl enable tuned --now

    echo "Setting tuned profile to balanced..."
    sudo tuned-adm profile balanced
fi

# Enable thermald
echo "Installing and enabling thermald..."
sudo dnf install -y thermald
sudo systemctl enable thermald --now

# Optional: Remove Powertop
echo ""
echo "Remove Powertop?"
read -p "Type Y/y to remove Powertop, or N/n to keep it: " pt_choice

if [[ "$pt_choice" == "Y" || "$pt_choice" == "y" ]]; then
    echo "Removing Powertop..."
    sudo dnf remove -y powertop

    echo "Removing Powertop auto-tune service (if exists)..."
    sudo systemctl disable powertop-autotune.service --now 2>/dev/null
    sudo rm -f /etc/systemd/system/powertop-autotune.service
else
    echo "Keeping Powertop and its auto-tune service."
fi

echo ""
echo "🎉 Fedora $fedora_version is restored to its default power management configuration."

