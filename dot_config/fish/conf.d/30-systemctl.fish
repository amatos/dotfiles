#!/usr/bin/env fish

abbr -a sctl --position command "sudo systemctl"
abbr -a sctls --position command "sudo systemctl status"
abbr -a sctle --position command "sudo systemctl enable --now"
abbr -a sctld --position command "sudo systemctl disable --now"
abbr -a sctlr --position command "sudo systemctl restart"
abbr -a sctlo --position command "sudo systemctl stop"
abbr -a sctla --position command "sudo systemctl start"
