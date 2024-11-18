#!/usr/bin/env bash

rm ~/.config/avizo/config.ini
ln -s ~/.config/avizo/config.light ~/.config/avizo/config.ini
pkill avizo-server
uwsm app -- avizo-service
