#!/usr/bin/env bash
# First-run script: bootstraps secrets on a fresh NixOS install.
# Run with: nix-shell -p bitwarden-cli jq --run "bash bootstrap.sh"
set -euo pipefail

read -p "BW_CLIENTID: " BW_CLIENTID
read -sp "BW_CLIENTSECRET: " BW_CLIENTSECRET; echo
read -sp "Master password: " BW_PASSWORD; echo
export BW_CLIENTID BW_CLIENTSECRET

export BW_PASSWORD
bw login --check >/dev/null 2>&1 || bw login --apikey
printf "\033[32mLogged in.\033[0m\n"

BW_SESSION="$(bw unlock --passwordenv BW_PASSWORD --raw)"
export BW_SESSION
bw sync

sudo mkdir -p /var/lib/sops
bw get item "NixOS sops age key" | jq -r '.notes' | sudo tee /var/lib/sops/age.key > /dev/null
sudo chmod 600 /var/lib/sops/age.key
printf "\033[32mage key placed.\033[0m\n"

mkdir -p ~/.ssh
bw get item "NixOS bootstrap SSH key" | jq -r '.sshKey.privateKey' > ~/.ssh/id_bootstrap
chmod 600 ~/.ssh/id_bootstrap
printf "\033[32mbootstrap SSH key placed.\033[0m\n"

echo ""
printf "Next: \033[32msudo nixos-rebuild switch --flake .#shalev\033[0m\n"
