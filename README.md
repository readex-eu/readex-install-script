# readex-install-script

A script for downloading and installing the software components of the READEX Tool Suite.

Note: Before running the script, edit it and provide the right paths to the required software, if necessary.

    ./readex-install.sh <installation path>

If no installation path is specified, it will be installed in the /opt directory.

After checking the required software you can continue or abort the installation. 
```
Do you want to continue with the Installation of READEX Tool Suite? (yes|no)
```

The installation of x86_adapt is optional, so you can decide if it should be installed. 
```
Do you want to install x86_adapt? (yes|no)
```

After the script ran successfully, you can clean your work directory or keep the archive files and directories.
```
Do you want to clean the current directory? (yes|no)
```

# Requirements

Please make sure you have installed the required software on your system:

- GCC (G++ and GFortran) 6.3.0/7.1.0 or Intel compiler 2017.2.174/2018.1.163
- Bison 3.0.4
- PAPI 5.5.1 or higher
- Python 3.6 or higher
- Ace 6.5.0
- Flex 2.5.39
- Boost 1.65.0
- Cereal 1.2.1
- CMake 3.11 or higher
- Lua 5.1 or higher

If the `readex-install.sh` doesn't find right versions of the required software, the script will install it in the installation path or if the right version is in the package repository, it will be installed with `sudo apt-get install <package>`.


