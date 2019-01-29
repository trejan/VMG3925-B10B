# Firmware for the Zyxel VMG3925-B10B

V5.13(AAVF.12)C0 for a Zyxel VMG3925-B10B with baby jumbo frames (1508) support enabled. The stock Zyxel firmware is limited to 1492 MTU for bridging.

The baby jumbo frame change and the firmware binary have been tested on several VMG3925-B10B units with success but you apply it to your own equipment at your own risk. This software is provided "as is," without warranty of any kind, express or implied. In no event shall the author or contributors be held liable for any damages arising in any way from the use of this software.

## Version information

* Bootbase version : V1.63 | 05/25/2018 17:40:14
* Firmware version : V5.13(AAVF.12)C0
* Kernel version: 3.4.11
* WLAN code version: 7.14.164.20.cpe4.16L05.0-kdb
* DSL mode code version: A2pv6F039x6
* DSL driver version: d26s
* 3G dongle WWAN package version: 1.18

See ftp://ftp.zyxel.com/VMG3925-B10B/firmware for release notes.

## Instructions

1. You must use the 32-bit version of [Ubuntu 12.04.5 LTS Desktop](http://releases.ubuntu.com/12.04/) to build this firmware. Using anything else is likely to cause buildroot to fail and generate nothing or a broken firmware image.

2. Run `sudo apt-get update`

3. Run `sudo dpkg-reconfigure dash` and select no.

4. Install necessary tools with `sudo apt-get install -y g++ flex bison gawk make autoconf zlib1g-dev libncurses-dev git subversion gettext`

5. Clone this repo somewhere.

6. Change to cloned repo directory.

7. Run `make dirclean`

8. Run `make`

9. The complete firmware image is bin/brcm963xx/zyxel/ras.bin and should be roughly 28MB.

## Flashing instructions

Flash the .bin file via the Maintenance -> Firmware Upgrade menu in the web UI. You'll need to log in as admin or supervisor.

If the Firmware Upgrade option is not available then you can use FTP instead to upload the firmware even if you only know the admin password. Check that FTP is enabled in Maintenance -> Remote Management. Transfer the .bin into the fw directory and it should immediately apply the upgrade then reboot. Make sure it is using binary mode when transferring the .bin file.

```
build@zyxelbuilder:~$ ftp 192.168.1.1
Connected to 192.168.1.1.
220---------- Welcome to Pure-FTPd [privsep] ----------
220-You are user number 1 of 50 allowed.
220-Local time is now 06:00. Server port: 21.
220-IPv6 connections are also welcome on this server.
220 You will be disconnected after 15 minutes of inactivity.
Name (192.168.1.1:build): admin
331 User admin OK. Password required
Password:
230 OK. Current restricted directory is /
Remote system type is UNIX.
Using binary mode to transfer files.
ftp> cd fw
250 OK. Current directory is /fw
ftp> put V5.13AAVF.12C0-jumbo.bin
local: V5.13AAVF.12C0-jumbo.bin remote: V5.13AAVF.12C0-jumbo.bin
200 PORT command successful
150 Connecting to port 58455
226 File successfully transferred
ftp> exit
```

If you can't use the Firmware Upgrade page and can't enable FTP on the Remote Management page then you'll need to open the router to use the 3.3V LVTTL console port to gain access to the bootloader. The connections are clearly marked on the PCB. Make sure your serial adapter is 3.3V as 5V or RS232 levels will damage it. The instructions for this are detailed elsewhere. The ATSE model is VMG3926 instead of VMG3925.

## Binaries

Precompiled firmware is on the releases page.

If you wish to revert to the stock firmware then download it from Zyxel and reflash it using the web interface.

## Original source

You can request the VMG3925-B10B firmware source yourself from Zyxel using their [GPL source request form](https://www.zyxel.com/us/en/form/gpl_oss_form.shtml). You'll need the serial number from your VMG3925-B10B to do so. The initial commit to this repo is the unmodified firmware source with an additional README.md file. Thanks to kabalin for [posting the instructions on how to verify the source](https://github.com/trejan/VMG3925-B10B/issues/1#issuecomment-426970503).

## License

All changes licensed as GPL. Please check licenses for individual packages and binaries.

## Original README follows:

```ReadMe for VMG3925-B10B(V5.13(AAVF.12)C0)


0. Introduction

  This file will show you how to build the VMG3925-B10B linux system,
  please note, the download image will overwrite the original image existed in the flash memory of EV board.


1. Files list

   A. README					- This file

   B. V513AAVF12C0_GPL.tar.bz2	- Open Source Code of VMG3925-B10B and Open Source Code of Toolchain


2. Prepare the build OS.

   A. We suggest using the Linux distribution to setup your environment for reduce compatible issue.

	Install Ubuntu 12.04 Desktop 32bit

   B. Update system

       Use GUI interface to update system or use command to update system.

	$ sudo apt-get update
	
   *Note: If update failed, edit /etc/apt/sources.list as following link
	deb http://old-releases.ubuntu.com/ubuntu/ precise main
	deb-src http://old-releases.ubuntu.com/ubuntu/ precise main
	deb http://old-releases.ubuntu.com/ubuntu/ precise-updates main
	deb-src http://old-releases.ubuntu.com/ubuntu/ precise-updates main
	deb http://old-releases.ubuntu.com/ubuntu/ precise universe
	deb-src http://old-releases.ubuntu.com/ubuntu/ precise universe
	deb http://old-releases.ubuntu.com/ubuntu/ precise-updates universe
	deb-src http://old-releases.ubuntu.com/ubuntu/ precise-updates universe
	deb http://old-releases.ubuntu.com/ubuntu precise-security main
	deb-src http://old-releases.ubuntu.com/ubuntu precise-security main
	deb http://old-releases.ubuntu.com/ubuntu precise-security universe
	deb-src http://old-releases.ubuntu.com/ubuntu precise-security universe


   C. Change default /bin/sh link to /bin/bash

	$ sudo dpkg-reconfigure dash
	choice "no" and press enter.


3. Prepare the compiler environment

   Install the following necessary tools 

	$ sudo apt-get install -y g++ flex bison gawk make autoconf zlib1g-dev libncurses-dev git subversion gettext


4. Extract the open source code

	$ tar jxf <FW Tarbal File>


5. Build the firmware for Web-GUI upgrade using

   Change the directory into extrated directory

	$ cd <extrated directory>

	
   Clean and build the firmware

	$ make dirclean
	$ make


6. The image is in the images directory.

    The firmware image will locate at <extrated directory>/bin/brcm963xx/zyxel/ras.bin
    You can use it update VMG3925-B10B by using the firmware update procedure.


```
