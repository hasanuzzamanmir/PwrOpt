#!/bin/bash
echo " Running Power_Optimizer..."
echo "--------------------------------------------------"
# Check for internet connectivity
if ! ping -q -c 2 -W 2 dl.fedoraproject.org > /dev/null 2>&1; then
    echo " Error: No internet connection."
    echo " Connect to internet and re-run this script."
    exit 1
else
    echo ""
fi

echo "Verify It's You "
# Install TLP
sudo dnf install -y tlp tlp-rdw
echo "Installing TLP  "
sudo systemctl enable tlp --now
echo "tlp is enabled "

# Disable power-profiles-daemon
echo "Disabling power-profiles-daemon to avoid conflicts with TLP... "
sudo systemctl mask power-profiles-daemon

# thermald
echo " --------------------------------------------------" 
echo "Disable thermald?:It can interfere with performance modes by throttling CPU even at safe temperatures."
read -p "Type Y/y to disable thermald, or N/n to keep it: " thermald_choice

if [[ "$thermald_choice" == "Y" || "$thermald_choice" == "y" ]]; then
    echo "Disabling thermald...."
    sudo systemctl disable thermald --now
else
    echo "Keeping thermald enabled."
fi

# Powertop
echo "--------------------------------------------------"
echo "Install Powertop ? (live power tuning and diagnostics) "
read -p "Type Y/y to install Powertop, or N/n to skip: " pt_choice

if [[ "$pt_choice" == "Y" || "$pt_choice" == "y" ]]; then
    sudo dnf install -y powertop
    echo "Powertop installed. "

    echo ""
    echo "Powertop to auto-tune at every reboot?"
    read -p "Y/y to enable Powertop auto-tune, or N/n to skip: " auto_choice

    if [[ "$auto_choice" == "Y" || "$auto_choice" == "y" ]]; then
        echo "Creating systemd service for Powertop auto-tune..."
        sudo bash -c 'cat > /etc/systemd/system/powertop-autotune.service <<EOF
[Unit]
Description=Powertop auto-tune
After=multi-user.target

[Service]
Type=oneshot
ExecStart=/usr/bin/powertop --auto-tune

[Install]
WantedBy=multi-user.target
EOF'

        sudo systemctl enable powertop-autotune.service
        echo "Powertop auto-tune will run at every boot."
    else
        echo "Skipping Powertop auto-tune setup."
    fi
else
    echo "Skipping Powertop installation."
fi

echo " "
echo "🎉 Setup complete! Your Fedora system is now optimized for battery life.🎉"

echo "To restore default ...use 'PowerRest' script".
