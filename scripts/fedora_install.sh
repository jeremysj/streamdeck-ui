#!/bin/bash -xe
echo "Installing libraries"
sudo dnf install python3-devel libusb-devel libusbx-devel libudev-devel systemd-devel
echo "Adding udev rules and reloading"
sudo usermod -a -G plugdev `whoami`

sudo tee /etc/udev/rules.d/99-streamdeck.rules << EOF
SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", MODE="0666", ACTION!="add" \
ATTR{idVendor}=="0fd9", ATTR{idProduct}=="006d"
SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", MODE="0666", ACTION!="add" \
ATTR{idVendor}=="0fd9", ATTR{idProduct}=="0060"
SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", MODE="0666", ACTION!="add" \
ATTR{idVendor}=="0fd9", ATTR{idProduct}=="0063"
SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", MODE="0666", ACTION!="add" \
ATTR{idVendor}=="0fd9", ATTR{idProduct}=="006c"
EOF

sudo udevadm control --reload-rules

echo "Unplug and replug in device for the new udev rules to take effect"
echo "Installing streamdeck_ui"
pip3 install --user streamdeck_ui
echo "If the installation was successful, run 'streamdeck' to start."
