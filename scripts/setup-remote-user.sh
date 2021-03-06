#!/usr/bin/env bash

echo "This is mostly instructions for how to create"
echo "a user on this system that a remote system"
echo "can use to log in for setting status, etc."
sudo useradd -m robotStatusUser
echo "sudo su - robotStatusUser"
echo "mkdir .ssh"
echo "cd .ssh"
echo "ssh-keygen"
echo "cp id_rsa.pub authorized_keys"
echo "scp id_rsa root@pi:robotStatusUser.key"
echo "exit"
echo "On remote host:"
echo "ssh -i robotStatusUser.key robotStatusUser@arlobot"
