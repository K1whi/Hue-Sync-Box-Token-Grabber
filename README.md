# Hue-Sync-Box-Token-Grabber
A lightweight Bash script to easily retrieve the **Access Token** (also known as `registrationId`) from the Philips Hue Sync Box local API.

## 🧐 Why use this?
The Hue Sync Box API requires you to send a POST request **at the exact moment** you are holding down the physical button on the device.
This can be frustrating if your computer is not right next to your TV.

**This script solves the timing issue** by sending connection requests repeatedly (every second for 30 seconds), giving you ample time to walk over to the device and press the button.

## 🚀 Features
- **Zero Dependencies:** Uses standard `curl` (pre-installed on macOS and most Linux distros).
- **Burst Mode:** Automatically retries connection until the button is pressed.
- **Clean Output:** Extracts and displays only the token you need.

## 🛠 Usage

1. **Download the script** (or copy the code to a file named `get-hue-token.sh`).
2. **Make it executable**:
   ```bash
   chmod +x get-hue-token.sh
