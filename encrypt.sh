#!/usr/bin/env bash

# Create workspace
mkdir -p helvia-workspace

# Store pub key locally
cat >./helvia-workspace/helvia_pub_key.pem <<EOL
-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAzx/G7PtBQAtoRKLT9MH2
vnNzfzCG8kpM+DlZlMzLUbnMR7Oh6fH94bTAk3EnZAAW8q9BsRgnPxDQwau/5JRr
y7Sq7nQgDewms84iPyaoxQj9XeB3crydkEpP7G+KIrIr/c4eLgZn7YoNz5AR7lQO
lYnSrM37+o6MiiBGJHOkMDGiiurVFkgstTUMfdnlz4+CfGb8+DyfhhS48J72RdQ/
4XG03XM+w6wgNkgI9FZKsS03X0f2XWxmZxZrFv+Td3f7wz0QLpJIJ8Dcaqh/itJH
ReZDphXrlhntt4DL8qOhZvq3oaiz6scZ3Ld7FMpU1pdQ80UHIEl4ZlePsP8/GhC9
aQIDAQAB
-----END PUBLIC KEY-----
EOL

# Create symmetric key
openssl rand -base64 32 > ./helvia-workspace/symmetric_key.bin

# Encrypt symmetric key
openssl rsautl -encrypt -inkey ./helvia-workspace/helvia_pub_key.pem -pubin -in ./helvia-workspace/symmetric_key.bin -out ./helvia-workspace/symmetric_key.bin.enc

# tar-gz Directory and encrypted random file
tar czf ./helvia-workspace/data.tar.gz $1

# Encrypt file or directory
openssl enc -aes-256-cbc -salt -in ./helvia-workspace/data.tar.gz -out ./helvia-workspace/data.tar.gz.enc -pass file:./helvia-workspace/symmetric_key.bin

# Create bun
tar czf ./enc_data_bundle.tar.gz -C ./helvia-workspace data.tar.gz.enc symmetric_key.bin.enc

echo "
==========================================================================================
Data encryption completed! Please send the file 'enc_data_bundle.tar.gz' to Helvia.io
==========================================================================================
"

# Remove workspace
rm -rf  helvia-workspace
