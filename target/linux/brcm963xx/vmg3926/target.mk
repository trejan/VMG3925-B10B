ARCH:=mips

#----------- Configuration
# Following configuration are copy from BCM SDK-4.1.4 version
#  Reference:
include $(INCLUDE_DIR)/kernel.mk

export BOARD_TYPE=vmg3926

##### for inculding make.common BCM SDK define ######
export BCM_BOARD_NAME=$(shell echo $(BOARD_TYPE) | tr a-z A-Z)
export BCM_PROFILE=VMG3926
export BRCM_CHIP=63268
export KERNEL_BUILD_DIR LINUX_DIR TOOLCHAIN_DIR TARGET_DIR TARGET_CROSS SCRIPT_DIR
export BCM_BUILD_DIR=$(KERNEL_BUILD_DIR)/broadcom-sdk-$(shell echo $(CONFIG_BRCM_SDK_VERSION))
export BCM_HOSTTOOLS_DIR=$(STAGING_DIR_HOST)/bin/$(shell echo $(CONFIG_BRCM_SDK_VERSION))
export BCM_INSTALL_DIR=$(BCM_BUILD_DIR)/targets/$(BCM_PROFILE)/fs.install
ifneq ($(findstring _$(strip $(BRCM_CHIP))_,_63138_63148_),)
export FLASH_BOOT_OFS=65536
else
export FLASH_BOOT_OFS=0
endif

export BRCMDRIVERS_DIR=$(BCM_BUILD_DIR)/bcmdrivers
export SHARED_DIR=$(BCM_BUILD_DIR)/shared

export INC_BRCMDRIVER_PUB_PATH=$(BRCMDRIVERS_DIR)/opensource/include
export INC_BRCMDRIVER_PRIV_PATH=$(BRCMDRIVERS_DIR)/broadcom/include
export INC_BRCMSHARED_PUB_PATH=$(SHARED_DIR)/opensource/include
export INC_BRCMSHARED_PRIV_PATH=$(SHARED_DIR)/broadcom/include

export BRCM_BOARD=bcm963xx
########### Add CONFIG_BUILD_MSTC_VOICE_KSOCKET_RTP compile flag for VoIP related feature(Kernel Socket) ###########
export CONFIG_BUILD_MSTC_VOICE_KSOCKET_RTP
######################
###############################
ifeq ($(CONFIG_SAME_FW_FOR_TWO_BOARD),y)
export SAME_FW_FOR_TWO_BOARD=y
endif

ifeq ($(CONFIG_ZYXEL_FEATURE_BITS),y)
export ZYXEL_FEATURE_BITS=y
endif

#__ZyXEL__, for ZyXEL hardware depend misc.
ifeq ($(CONFIG_ZYXEL_QTN_WIFI_5G_SUPPORT),y)
export ZYXEL_QTN_WIFI_5G_SUPPORT=y
endif
ifeq ($(CONFIG_ZYXEL_QTN_SW_RESET),y)
export ZYXEL_QTN_SW_RESET=y
endif
ifeq ($(CONFIG_ZYXEL_WPS_SPOTLIGHT),y)
export ZYXEL_WPS_SPOTLIGHT=y
ifeq ($(CONFIG_ZYXEL_WPS_SPOTLIGHT_2GPIO),y)
export ZYXEL_WPS_SPOTLIGHT_2GPIO=y
endif
endif
ifeq ($(CONFIG_ZYXEL_SFP_MODULE_SUPPORT),y)
export ZYXEL_SFP_MODULE_SUPPORT=y
endif
ifeq ($(CONFIG_ZYXEL_SFP_DETECT_PIN),y)
export ZYXEL_SFP_DETECT_PIN=y
endif
ifeq ($(CONFIG_ZYXEL_SFP_TX_FAULT_PIN),y)
export ZYXEL_SFP_TX_FAULT_PIN=y
endif
## 2.4G FEM detection
ifeq ($(CONFIG_ZYXEL_FEM_DETECT),y)
export ZYXEL_FEM_DETECT=y
endif
#----------- End of configuration

BOARDNAME:=$(BCM_BOARD_NAME)
#CFLAGS:=-Os -pipe -funit-at-a-time -march=74kc -mtune=74kc
#DEFAULT_PACKAGES+=kmod-usb-core kmod-usb-storage kmod-usb-net kmod-usb2

define Target/Description
        Build firmware images for VMG3926 board.
endef

