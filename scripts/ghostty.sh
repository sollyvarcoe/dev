#!/bin/bash
set -e

# Define the GitHub repository and Ubuntu version
REPO="mkasberg/ghostty-ubuntu"
UBUNTU_VERSION=$(lsb_release -rs)
ARCH=$(dpkg --print-architecture)

# Inform the user
echo "Attempting to install Ghostty for Ubuntu ${UBUNTU_VERSION} on ${ARCH}..."
echo "Using GitHub repository: https://github.com/${REPO}"

# Fetch the latest release information
API_URL="https://api.github.com/repos/${REPO}/releases/latest"
DEB_URL=$(curl -s "${API_URL}" | \
  jq -r ".assets[] | select(.name | contains(\"${ARCH}_${UBUNTU_VERSION}\") and endswith(\".deb\")) | .browser_download_url")

# Check if a download URL was found
if [[ -z "${DEB_URL}" ]]; then
  echo "Error: No .deb package found for Ubuntu ${UBUNTU_VERSION} and architecture ${ARCH}."
  echo "You may need to manually find and install the correct package from the releases page."
  exit 1
fi

# Get the filename from the URL
DEB_FILE=$(basename "${DEB_URL}")
INSTALL_DIR=$(mktemp -d)

echo "Downloading ${DEB_FILE} to ${INSTALL_DIR}..."

# Download the .deb package
curl -L -o "${INSTALL_DIR}/${DEB_FILE}" "${DEB_URL}"

# Install the package using dpkg
echo "Installing Ghostty..."
sudo dpkg -i "${INSTALL_DIR}/${DEB_FILE}"

# Remove the temporary directory
rm -rf "${INSTALL_DIR}"

echo "Ghostty installation complete!"
echo "You can now run 'ghostty' from your terminal."
