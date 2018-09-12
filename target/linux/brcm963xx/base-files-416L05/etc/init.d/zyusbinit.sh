#!/bin/sh
echo -e "\033[1;34mInitial USB driver...\033[0m"
KERNELVER=`uname -r`

#load usb modules
 test -e /lib/modules/$KERNELVER/kernel/drivers/usb/usb-common.ko && insmod /lib/modules/$KERNELVER/kernel/drivers/usb/usb-common.ko
 test -e /lib/modules/$KERNELVER/kernel/drivers/usb/core/usbcore.ko && insmod /lib/modules/$KERNELVER/kernel/drivers/usb/core/usbcore.ko
 test -e /lib/modules/$KERNELVER/kernel/drivers/usb/host/xhci-hcd.ko && insmod /lib/modules/$KERNELVER/kernel/drivers/usb/host/xhci-hcd.ko
 test -e /lib/modules/$KERNELVER/kernel/drivers/usb/host/ehci-hcd.ko && insmod /lib/modules/$KERNELVER/kernel/drivers/usb/host/ehci-hcd.ko
 test -e /lib/modules/$KERNELVER/kernel/drivers/usb/host/ohci-hcd.ko && insmod /lib/modules/$KERNELVER/kernel/drivers/usb/host/ohci-hcd.ko
 test -e /lib/modules/$KERNELVER/kernel/arch/arm/plat-bcm63xx/bcm63xx_usb.ko && insmod /lib/modules/$KERNELVER/kernel/arch/arm/plat-bcm63xx/bcm63xx_usb.ko
 test -e /lib/modules/$KERNELVER/kernel/drivers/usb/class/usblp.ko && insmod /lib/modules/$KERNELVER/kernel/drivers/usb/class/usblp.ko
 test -e /lib/modules/$KERNELVER/kernel/drivers/usb/storage/usb-storage.ko && insmod /lib/modules/$KERNELVER/kernel/drivers/usb/storage/usb-storage.ko
 test -e /lib/modules/$KERNELVER/btusbdrv.ko && insmod /lib/modules/$KERNELVER/btusbdrv.ko

#EJECT need
 test -e /lib/modules/$KERNELVER/cdrom.ko && insmod /lib/modules/$KERNELVER/cdrom.ko
 test -e /lib/modules/$KERNELVER/isofs.ko && insmod /lib/modules/$KERNELVER/isofs.ko
 