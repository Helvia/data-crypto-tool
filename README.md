# Helvia.io Data Encryption Command Line Tool

This is a simple command line tool to encrypt sensitive information before sending it to Helvia.io.

The tool uses RSA Public Key Cryptography to encrypt a randomly generated symmetric key,
 which then uses to encrypt the data with the AES block cipher.

## Requirements

To use this tool you need:

1. a unix-like environment (unix, linux, osx or putty, cygwin)
2. openssl
3. tar

## Encrypt

First off, you need to download or checkout this repository to your unix/linux/osx environment.
Encrypting the data is as simple as running the following command:

```
./encrypt.sh <path_to_directory_containing_the_data>
```

The product of this script is an archive named enc_data_bundle.tar.gz and placed in the current directory.

## Dencrypt data (for Helvia admins)
To decrypt the archive created with the encrypt command of this tool, run:

```
./decrypt.sh <path_to_archive_containing_the_data> <path_to_helviaprivate_rsa_key>
```