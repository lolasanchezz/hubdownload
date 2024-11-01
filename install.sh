#!/bin/bash
USER=$(whoami)
echo 'Enter your email:'
read  email
echo "Enter your password 😊 {your input won't show for security purposes!!}"
read -s password


curl -o install_nvm.sh https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh
bash install_nvm.sh
rm install_nvm.sh

nvm install 20

if ! node -v > /dev/null 2>&1; then
  echo "Node didn't install 😔"
  exit 1
fi

mkdir -p ~/.assignmentsScript
cd ~/.assignmentsScript || exit 1
curl -O https://raw.githubusercontent.com/lolasanchezz/silver-giggle/refs/heads/main/index.js 
curl -O https://raw.githubusercontent.com/lolasanchezz/silver-giggle/refs/heads/main/package.json 
npm install

# Append credentials securely (note: storing them here is insecure, ideally avoid this)
echo "const username = \"$email\", password = \"$password\";" >> index.js

# Write the LaunchAgent plist file with corrected syntax
cat << EOF | sudo tee ~/Library/LaunchAgents/com.lolas.getassignments.plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.lolas.getassignments</string>
    <key>Program</key>
    <string>/Users/$USER/.assignmentsScript/index.js</string>
    <key>StandardErrorPath</key>
    <string>/tmp/com.lolas.getassignments.err</string>
    <key>StandardOutPath</key>
    <string>/tmp/com.lolas.getassignments.out</string>
    <key>StartInterval</key>
    <integer>300</integer>
</dict>
</plist>
EOF

# Load the Launch Agent
launchctl load ~/Library/LaunchAgents/com.lolas.getassignments.plist



