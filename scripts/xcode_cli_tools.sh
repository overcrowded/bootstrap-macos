#!/usr/bin/env bash

# Update the OS and Install Xcode Tools
echo
echo -e "\033[1mBOOTSTRAP_MACOS:\033[0m Running update of macOS: ./scripts/xcode_cli_tools.sh"
echo "    (restart if needed and run again): ./scripts/xcode_cli_tools.sh"
echo
sudo softwareupdate -ia --verbose

# Install Xcode CLI tools
if ! $(xcode-select -p &>/dev/null); then
  echo
  echo -e "\033[1mBOOTSTRAP_MACOS:\033[0m Running install of Xcode CLI tools:"
  echo    "./scripts/xcode_cli_tools.sh"
  echo
  sudo xcode-select --install
  # Wait until the Xcode CLI tools are done installing
  until $(xcode-select -p &>/dev/null); do
    sleep 5
  done
  # Setup the Xcode CLI tools path
  sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
fi

# Check that the Xcode CLI tools path is set
if [ ! -d "$(xcode-select -print-path)" ]; then
  echo
  echo -e "\033[1mBOOTSTRAP_MACOS:\003[0m Something went wrong trying to set the Xcode CLI tools path"
  echo
  exit 1
fi

# Install additional required components
/Applications/Xcode.app/Contents/MacOS/Xcode -installComponents
for pkg in /Applications/Xcode.app/Contents/Resources/Packages/*.pkg; do
  sudo installer -pkg "$pkg" -target /
done

# Install macOS SDK headers
if [ -f /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_11.7.pkg ]; then
  sudo installer -pkg /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_11.7.pkg -target /
fi
