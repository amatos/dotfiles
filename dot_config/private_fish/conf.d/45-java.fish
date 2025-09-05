#!/usr/bin/env fish

# Add Java jdk to system path
fish_add_path /opt/homebrew/opt/openjdk/bin

# Set compiler flags to include openjdk
set -gx CPPFLAGS "-I/opt/homebrew/opt/openjdk/include"
