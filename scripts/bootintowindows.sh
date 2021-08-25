#!/bin/bash

bootwindows () {
  grub-reboot "$(grep -i windows /boot/grub/grub.cfg|cut -d "'" -f2)" || exit 1
  reboot
}

gksu bash -c "$(declare -f bootwindows); bootwindows"
