#!/bin/bash
USER = $(whoami)
echo 'enter in your email'
read email
echo 'and password 😊'
read password


curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
sudo installer -pkg node.pkg -target /
nvm install 20

node -v
npm -v

if !(node -v > /dev/null 2>&1); then
  echo "node didnt install 😔"
  exit 1
fi

mkdir .assignmentsScript
cd .assignmentsScript
curl https://raw.githubusercontent.com/lolasanchezz/silver-giggle/refs/heads/main/index.js 
curl https://raw.githubusercontent.com/lolasanchezz/silver-giggle/refs/heads/main/package-lock.json 
npm install
cd
# Copy the plist file to the LaunchAgents directory
echo '<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    
    <key>Label</key>
    <string>com.lolas.getassignments</string>

    <key>Program</key>
    <string>/Users/$(USER)_/.assignmentsScript/index.js<string>
    
    <key>StandardErrorPath</key>
    <string>/tmp/com.lolas.getassignments.err</string>
    
    <key>StandardOutPath</key>
    <string>/tmp/com.lolas.getassignments.out</string>
    
    <key>StartInterval</key>
    <integer>300</integer>

</dict>
</plist>' | sudo tee ~/Library/LaunchAgents/com.lolas.getassignment.plist





# Load the Launch Agent
launchctl load ~/Library/LaunchAgents/com.lolas.getassignment.plist
launchctl bootstrap system/com.lolas.getassignments

