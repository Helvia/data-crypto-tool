#!/usr/bin/env bash

# Create workspace
mkdir -p helvia-workspace

# Untar archive
tar xfz $1 -C ./helvia-workspace

# Decrypt key
openssl rsautl -decrypt -inkey $2 -in ./helvia-workspace/symmetric_key.bin.enc -out ./helvia-workspace/symmetric_key.bin

# Decrypt archive
openssl enc -d -aes-256-cbc -in ./helvia-workspace/data.tar.gz.enc -out ./helvia-workspace/data.tar.gz -pass file:./helvia-workspace/symmetric_key.bin

# Untar data
tar xfz ./helvia-workspace/data.tar.gz -C ./helvia-workspace
