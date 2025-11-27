#!/bin/bash

# -------------------------------------------------------
# Philips Hue Sync Box - Access Token Grabber
# -------------------------------------------------------
# This script attempts to register with the Hue Sync Box
# repeatedly until the user presses the physical button
# on the device.
# -------------------------------------------------------

# 1. Configuration
echo "-----------------------------------------------"
echo "   Hue Sync Box Token Generator (Burst Mode)"
echo "-----------------------------------------------"
echo -n "Enter your Sync Box IP address: "
read IP_ADDRESS

echo ""
echo "🚀 Starting connection attempts (1 per second)..."
echo "👉 PLEASE PRESS AND HOLD THE BUTTON ON YOUR SYNC BOX NOW."
echo "   (Release when the LED flashes green)"
echo "-----------------------------------------------"

# 2. Retry Loop (30 attempts)
MAX_RETRIES=30

for ((i=1;i<=MAX_RETRIES;i++)); do
   # Silent request (-s), insecure (-k) for self-signed certs
   response=$(curl -k -s -X POST "https://$IP_ADDRESS/api/v1/registrations" \
     -H "Content-Type: application/json" \
     -d '{"appName":"homebridge-plugin","instanceName":"token-script"}')

   # Check for success
   if [[ $response == *"accessToken"* ]]; then
      echo ""
      echo "✅ SUCCESS (Attempt #$i)!"
      echo "-----------------------------------------------"
      echo "Here is your Access Token:"
      echo ""
      # Extract token cleanly
      echo $response | grep -o '"accessToken":"[^"]*"' | cut -d'"' -f4
      echo ""
      echo "-----------------------------------------------"
      echo "(Copy the string above without quotes)"
      exit 0
   else
      echo "⏳ Attempt $i/$MAX_RETRIES: Waiting for button press..."
      sleep 1
   fi
done

echo ""
echo "❌ Timeout. Please run the script again."
exit 1
