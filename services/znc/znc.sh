#!/bin/bash
set -e
set -x

## Install ZNC
apk --no-cache add znc znc-extra

## Copy default config file
mkdir -p /usr/share/znc/configs
cp /bd_build/services/znc/znc.conf /usr/share/znc/configs/znc.conf
chown abc:abc /usr/share/znc -R

## Copy runit file
mkdir -p /etc/service/znc
cp /bd_build/services/znc/znc.runit /etc/service/znc/run
