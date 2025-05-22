#!/usr/bin/env bash

cat ./secureboot > /etc/dracut.conf.d/secureboot.conf

cat ./zz-sbctl > /etc/pacman.d/hooks/zz-sbctl.hook
