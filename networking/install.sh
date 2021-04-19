#!/usr/bin/env sh
canonical=$(cd -P -- "$(dirname -- "$0")" && printf '%s\n' "$(pwd -P)/$(basename -- "$0")")


curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/focal.gpg | sudo apt-key add -
curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/focal.list | sudo tee /etc/apt/sources.list.d/tailscale.list


sudo apt install -y openfortivpn tailscale dnsmasq

# TODO: Review how to change this default settings, probably changing the dhclient configuration
connections="4e807030-bf0d-4817-9b53-c0f4018a8067 405f2e22-6a28-4bef-a228-f8e14b60db64"
for conn in $connections 
do
    nmcli con mod "${conn}" ipv4.ignore-auto-dns yes
    nmcli con mod "${conn}" ipv4.dns "127.0.0.1 192.168.0.1"
    nmcli con mod down "${conn}"
    nmcli con mod up "${conn}"
done

sudo cp "$(dirname "${canonical}")/dnsmasq.conf" /etc/dnsmasq.d/local_config
sudo systemctl restart dnsmasq
