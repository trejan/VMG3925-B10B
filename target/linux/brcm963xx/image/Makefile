# 
# Copyright (C) 2006-2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/image.mk
include $(INCLUDE_DIR)/zyxel-zy_feature_bits.mk

CONFIG_BRCM_CFE_BOOT_FROM_NAND=y
ifeq ($(CONFIG_BRCM_CFE_BOOT_FROM_NAND),y)
-include $(BCM_BUILD_DIR)/make.common
endif
SQUASHFS_BLOCKSIZE = 64k
SQUASHFSOPT = -b 64k

####export "ARCH_ENDIAN" for BCM SDK 416L01RC1 hosttool "bcmImageMaker" compatible with old version tool##############
ifeq ($(CONFIG_BIG_ENDIAN),y)
export ARCH_ENDIAN=big
SUMTOOLOPT=-b
TOOL_ENDIAN=
else
export ARCH_ENDIAN=little
SUMTOOLOPT=-l
TOOL_ENDIAN=-e little
endif

ifeq ($(CONFIG_FILL_IN_PARTITION_INFO_INTO_NVRAM),y)
export FLASH_TOTAL_SIZE=$(CONFIG_TARGET_NAND_FLASH_TOTAL_SIZE)
else
export FLASH_TOTAL_SIZE=0
endif

FLASHBLK_SIZE=$($(shell echo CONFIG_BRCMSDK$(CONFIG_BRCM_SDK_VERSION)_BRCM_FLASHBLK_SIZE))
JFFS2_BLOCKSIZE:=$(FLASHBLK_SIZE)k
SUMTOOL_BLOCKSIZE:=$(FLASHBLK_SIZE)KiB

ifneq ($(call qstrip,$(CONFIG_BRCM963xx_SDK_VER_416L04) $(CONFIG_BRCM963xx_SDK_VER_416L05)),)
ifneq ($(call qstrip,$($(shell echo CONFIG_BRCMSDK$(CONFIG_BRCM_SDK_VERSION)_BUILD_NOR_KERNEL_LZ4))),)
KERNEL_COMPRESSION=lz4
KERNEL_FILE_TYPE=lz4
else
KERNEL_COMPRESSION=lzma
KERNEL_FILE_TYPE=lz
endif
else
KERNEL_COMPRESSION=lzma
KERNEL_FILE_TYPE=lz
endif

#HOSTTOOLS_DIR=$(BCM_BUILD_DIR)/hostTools
HOSTTOOLS_DIR=$(STAGING_DIR_HOST)/bin/$(shell echo $(CONFIG_BRCM_SDK_VERSION))

# Get MRD information, used for hosttool; do $(shell echo xxxx) twice because need to remove quotes
export BRCM_VOICE_BOARD_ID=$($(shell echo CONFIG_BRCMSDK$(CONFIG_BRCM_SDK_VERSION)_BRCM_VOICE_BOARD_ID))
export VENDORNAME=$(call qstrip,$(CONFIG_MRD_VENDOR_NAME))
export PRODUCTNAME=$(call qstrip,$(CONFIG_MRD_PRODUCT_NAME))
export SERIALNUMBER=$(call qstrip,$(CONFIG_MRD_SERIAL_NO))
export FIRMWARE_VERSION=$(call qstrip,$(CONFIG_ZYXEL_FIRMWARE_VERSION))
export ZYXEL_MODEL_ID=$(call qstrip,$(CONFIG_MRD_MODEL_ID))
export MAINFEATUREBIT=$(call qstrip,$(CONFIG_MRD_MAIN_FEATURE_BIT))
export DEBUGBIT=$(call qstrip,$(CONFIG_MRD_DEBUG_BIT))
export COUNTRYCODE=$(call qstrip,$(CONFIG_MRD_COUNTRY_CODE))
export NVRAM_MEMORY_CONFIG=$(call qstrip,$(CONFIG_BCM63138_NVRAM_MEMORY_CONFIG))
export NVRAM_MC_MEMORY_ALLOCATION=$(call qstrip,$(CONFIG_BCM63138_NVRAM_MC_MEMORY_ALLOCATION))
export NVRAM_TM_MEMORY_ALLOCATION=$(call qstrip,$(CONFIG_BCM63138_NVRAM_TM_MEMORY_ALLOCATION))
export NVRAM_DHD0_MEMORY_ALLOCATION=$(call qstrip,$(CONFIG_BCM63138_NVRAM_DHD0_MEMORY_ALLOCATION))
export NVRAM_DHD1_MEMORY_ALLOCATION=$(call qstrip,$(CONFIG_BCM63138_NVRAM_DHD1_MEMORY_ALLOCATION))
export NVRAM_DHD2_MEMORY_ALLOCATION=$(call qstrip,$(CONFIG_BCM63138_NVRAM_DHD2_MEMORY_ALLOCATION))
export BRCM_MISC1_PARTITION_SIZE=$($(shell echo CONFIG_BRCMSDK$(CONFIG_BRCM_SDK_VERSION)_BRCM_MISC1_PARTITION_SIZE))
export BRCM_MISC2_PARTITION_SIZE=$($(shell echo CONFIG_BRCMSDK$(CONFIG_BRCM_SDK_VERSION)_BRCM_MISC2_PARTITION_SIZE))
export BRCM_MISC3_PARTITION_SIZE=$($(shell echo CONFIG_BRCMSDK$(CONFIG_BRCM_SDK_VERSION)_BRCM_MISC3_PARTITION_SIZE))

# Get common options
ZYXEL_RAS_FORMAT=$($(shell echo CONFIG_BRCMSDK${CONFIG_BRCM_SDK_VERSION}_ZYXEL_RSA_FORMAT))

# For zytool generate multi zld.bin
ZYXEL_ZYTOOL_SCRIPT_DIR=$(TOPDIR)/target/linux/brcm963xx/$(SUBTARGET)

define Image/Build/multi_zld
	##doing zytool shell script
	if [ -e $(ZYXEL_ZYTOOL_SCRIPT_DIR)/zytool_multi_zld.sh ]; then \
	if [ -e $(HOSTTOOLS_DIR)/zytool ]; then \
	$(ZYXEL_ZYTOOL_SCRIPT_DIR)/zytool_multi_zld.sh $(HOSTTOOLS_DIR) $(BIN_DIR)/zyxel $(BRCM_CHIP) $(ARCH_ENDIAN); \
	elif [ ! -e $(HOSTTOOLS_DIR)/zytool ]; then \
	echo "Please clean and rebuild host tools !!"; \
	exit -1; \
	fi \
	elif [ ! -e $(ZYXEL_ZYTOOL_SCRIPT_DIR)/zytool_multi_zld.sh ]; then \
	echo; \
	fi
endef

define Image/Build/merge_firmware
	echo;echo "!!! Package firmware for release !!!";echo
	mkdir -p $(BIN_DIR)/zyxel/
	# Generate the tagged image with BCM proprietary tool "bcmImageMaker/bcmImageBuilder"
ifeq ($(ZYXEL_RAS_FORMAT), y)
	##doing ZyXEL image formate
	$(call Image/mkfs/jffs2/sub/original,$(JFFS2_BLOCKSIZE))
	$(HOSTTOOLS_DIR)/scripts/bcmImageMaker --cferom $(BIN_DIR)/brcm-cfe/cfe$(BRCM_CHIP)rom.bin --blocksize $(shell expr 1024 \* $(FLASHBLK_SIZE)) --flashtotalsize $(FLASH_TOTAL_SIZE) --bootofs $(FLASH_BOOT_OFS) --bootsize $(shell expr 1024 \* $(FLASHBLK_SIZE)) --kernelimg $(KERNEL_BUILD_DIR)/vmlinux.lz --rootfs $(KERNEL_BUILD_DIR)/root.jffs2-$(JFFS2_BLOCKSIZE) --fake_rootfs $(KERNEL_BUILD_DIR)/fake_root.jffs2-$(JFFS2_BLOCKSIZE) --image $(BIN_DIR)/openwrt-nand-$(BOARDNAME)-jffs2-$(JFFS2_BLOCKSIZE)-cfe.bin --fsonly $(BIN_DIR)/openwrt-nand-$(BOARDNAME)-jffs2-$(JFFS2_BLOCKSIZE).bin 
else
	$(HOSTTOOLS_DIR)/scripts/bcmImageMaker --cferom $(BIN_DIR)/brcm-cfe/cfe$(BRCM_CHIP)rom.bin --blocksize $(shell expr 1024 \* $(FLASHBLK_SIZE)) --bootofs $(FLASH_BOOT_OFS) --bootsize $(shell expr 1024 \* $(FLASHBLK_SIZE)) --rootfs $(KERNEL_BUILD_DIR)/root.jffs2-$(JFFS2_BLOCKSIZE) --image $(BIN_DIR)/zyxel/openwrt-nand-$(BOARDNAME)-jffs2-$(JFFS2_BLOCKSIZE)-cfe.bin --fsonly $(BIN_DIR)/openwrt-nand-$(BOARDNAME)-jffs2-$(JFFS2_BLOCKSIZE).bin
endif
	cp $(BIN_DIR)/openwrt-nand-$(BOARDNAME)-jffs2-$(JFFS2_BLOCKSIZE).bin.w $(BIN_DIR)/zyxel/ras.bin
	dd if=$(BIN_DIR)/openwrt-nand-$(BOARDNAME)-jffs2-$(JFFS2_BLOCKSIZE)-cfe.bin.w of=$(BIN_DIR)/zyxel/zld.bin bs=1k count=$(FLASHBLK_SIZE)
ifneq ($(call qstrip,$(CONFIG_BRCM963xx_SDK_VER_416L05)), )
	$(call Image/Build/multi_zld)
endif
endef

define Image/Build/CFE
	mkdir -p $(BIN_DIR)/zyxel/
	# Generate the tagged image with BCM proprietary tool "bcmImageMaker/bcmImageBuilder"
ifeq ($(CONFIG_BRCM_CFE_BOOT_FROM_NAND),y)
ifeq ($(ZYXEL_RAS_FORMAT), y)
	##doing ZyXEL image formate
	$(HOSTTOOLS_DIR)/scripts/bcmImageMaker --cferom $(BIN_DIR)/brcm-cfe/cfe$(BRCM_CHIP)rom.bin --blocksize $(shell expr 1024 \* $(FLASHBLK_SIZE)) --flashtotalsize $(FLASH_TOTAL_SIZE) --bootofs $(FLASH_BOOT_OFS) --bootsize $(shell expr 1024 \* $(FLASHBLK_SIZE)) --kernelimg $(KERNEL_BUILD_DIR)/vmlinux.lz --rootfs $(KERNEL_BUILD_DIR)/root.$(1) --fake_rootfs $(KERNEL_BUILD_DIR)/fake_root.jffs2-$(JFFS2_BLOCKSIZE) --image $(BIN_DIR)/openwrt-nand-$(4)-$(1)-cfe.bin --fsonly $(BIN_DIR)/openwrt-nand-$(4)-$(1).bin 
else
	$(HOSTTOOLS_DIR)/scripts/bcmImageMaker --cferom $(BIN_DIR)/brcm-cfe/cfe$(BRCM_CHIP)rom.bin --blocksize $(shell expr 1024 \* $(FLASHBLK_SIZE)) --bootofs $(FLASH_BOOT_OFS) --bootsize $(shell expr 1024 \* $(FLASHBLK_SIZE)) --rootfs $(KERNEL_BUILD_DIR)/root.$(1) --image $(BIN_DIR)/openwrt-nand-$(4)-$(1)-cfe.bin --fsonly $(BIN_DIR)/openwrt-nand-$(4)-$(1).bin
endif
	cp $(BIN_DIR)/openwrt-nand-$(4)-$(1).bin.w $(BIN_DIR)/zyxel/ras.bin
	dd if=$(BIN_DIR)/openwrt-nand-$(4)-$(1)-cfe.bin.w of=$(BIN_DIR)/zyxel/zld.bin bs=1k count=$(FLASHBLK_SIZE)
ifneq ($(call qstrip,$(CONFIG_BRCM963xx_SDK_VER_416L05)), )
	$(call Image/Build/multi_zld)
endif
else
	$(HOSTTOOLS_DIR)/bcmImageBuilder --output $(BIN_DIR)/openwrt-$(4)-$(1).bin --chip $(3) --board $(2) --blocksize $(SQUASHFS_BLOCKSIZE) --image-version 4143GW2801456 --cfefile $(BIN_DIR)/brcm-cfe/cfe$(BRCM_CHIP).bin --rootfsfile $(BIN_DIR)/$(IMG_PREFIX)-root.$(1) --kernelfile $(KDIR)/vmlinux.lz
	cp $(BIN_DIR)/openwrt-$(4)-$(1).bin $(BIN_DIR)/zyxel/ras.bin
	cp $(BIN_DIR)/brcm-cfe/cfe$(BRCM_CHIP).bin $(BIN_DIR)/zyxel/zld.bin
	$(HOSTTOOLS_DIR)/bcmImageBuilder --output $(BIN_DIR)/openwrt-$(4)-$(1)-cfe.bin --chip $(3) --board $(2) --blocksize $(SQUASHFS_BLOCKSIZE) --image-version 4143GW2801456 --cfefile $(BIN_DIR)/brcm-cfe/cfe$(BRCM_CHIP).bin --rootfsfile $(KERNEL_BUILD_DIR)/root.$(1) --kernelfile $(KDIR)/vmlinux.lz --include-cfe
endif
endef

define Build/Clean
endef

define Image/mkfs/jffs2/sub/fake
	# Prepare a fake rootfs without default config and cferam.000
	rm -rf $(TARGET_DIR)_fake
	cp -afp $(TARGET_DIR) $(TARGET_DIR)_fake
	rm -f $(TARGET_DIR)_fake/etc/sysconfig.tar.gz $(TARGET_DIR)_fake/cferam.000
ifneq ($(call qstrip,$(CONFIG_KERNEL_JFFS2_SUMMARY)),y)
	$(STAGING_DIR_HOST)/bin/mkfs.jffs2 $(JFFS2OPTS) -e $(patsubst %k,%KiB,$(1)) -o $(KDIR)/fake_root.jffs2-$(1) -d $(TARGET_DIR)_fake -N $(BUILD_DIR)/nocomprlist -v 2>&1 1>/dev/null | awk '/^.+$$$$/'
else
	$(STAGING_DIR_HOST)/bin/mkfs.jffs2 $(JFFS2OPTS) -e $(patsubst %k,%KiB,$(1)) -o $(KDIR)/tmp_root.jffs2-$(1) -d $(TARGET_DIR)_fake -N $(BUILD_DIR)/nocomprlist -v 2>&1 1>/dev/null | awk '/^.+$$$$/'
	$(STAGING_DIR_HOST)/bin/sumtool $(SUMTOOLOPT) -p -i $(KDIR)/tmp_root.jffs2-$(1) -o $(KDIR)/fake_root.jffs2-$(1) -e $(SUMTOOL_BLOCKSIZE) -n
	rm $(KDIR)/tmp_root.jffs2-$(1)
endif

endef

define Image/mkfs/jffs2/sub/original
	$(HOSTTOOLS_DIR)/zyfwinfo -f $(TARGET_DIR)/cferam.000 -s -k $(KERNEL_BUILD_DIR)/vmlinux.lz -r $(KDIR)/fake_root.jffs2-$(1) $(TOOL_ENDIAN)
	touch -a -m -t 197001010000.00 $(TARGET_DIR)/cferam.000
	# FIXME: removing this line will cause strange behaviour in the foreach loop below
ifneq ($(call qstrip,$(CONFIG_KERNEL_JFFS2_SUMMARY)),y)
	$(STAGING_DIR_HOST)/bin/mkfs.jffs2 $(JFFS2OPTS) -e $(patsubst %k,%KiB,$(1)) -o $(KDIR)/root.jffs2-$(1) -d $(TARGET_DIR) -N $(BUILD_DIR)/nocomprlist -v 2>&1 1>/dev/null | awk '/^.+$$$$/'
else
	$(STAGING_DIR_HOST)/bin/mkfs.jffs2 $(JFFS2OPTS) -e $(patsubst %k,%KiB,$(1)) -o $(KDIR)/tmp_root.jffs2-$(1) -d $(TARGET_DIR) -N $(BUILD_DIR)/nocomprlist -v 2>&1 1>/dev/null | awk '/^.+$$$$/'
	$(STAGING_DIR_HOST)/bin/sumtool $(SUMTOOLOPT) -p -i $(KDIR)/tmp_root.jffs2-$(1) -o $(KDIR)/root.jffs2-$(1) -e $(SUMTOOL_BLOCKSIZE) -n
	rm $(KDIR)/tmp_root.jffs2-$(1)
endif

endef

define Image/mkfs/jffs2/sub
	# Add nocomprlist for compress whole rootfs but those two image cferam.000 and vmlinux.lz
	echo -e "/cferam.000" > $(BUILD_DIR)/nocomprlist
	if [ -e $(TARGET_DIR)/.ethWanAsLan ]; then \
		echo -e "/.ethWanAsLan" >> $(BUILD_DIR)/nocomprlist; \
	fi
	echo -e "/vmlinux.lz" >> $(BUILD_DIR)/nocomprlist

	$(call Image/mkfs/jffs2/sub/fake,$(1))

	$(call Image/mkfs/jffs2/sub/original,$(1))

	$(call Image/Build,jffs2-$(1))
	# no need to remove it
	#rm -rf $(BUILD_DIR)/nocomprlist
endef

ifneq ($(CONFIG_TARGET_ROOTFS_SQUASHFS),)
define Image/mkfs/squashfs
	@mkdir -p $(TARGET_DIR)/overlay
	$(STAGING_DIR_HOST)/bin/mksquashfs4 $(TARGET_DIR) $(KDIR)/root.squashfs -nopad -noappend -root-owned -comp $(SQUASHFSCOMP) $(SQUASHFSOPT) -processors $(if $(CONFIG_PKG_BUILD_JOBS),$(CONFIG_PKG_BUILD_JOBS),1)
	dd if=$(KDIR)/root.squashfs of=$(BIN_DIR)/$(IMG_PREFIX)-root.squashfs bs=$(SQUASHFS_BLOCKSIZE) conv=sync
	$(call Image/Build,squashfs)
endef
endif

define Image/mkfs/prepare
	#workaround: copy all *.ko to rootfs/lib/modules/xxx/; the correct way is modify package/kernel/modules/netfilter.mk, but it should care dependence.
	cp `find $(LINUX_DIR)/ -name "*.ko"` $(TARGET_DIR)/lib/modules/$(LINUX_VERSION)/
	cp `find $(BROADCOM_SDK_DIR)/bcmdrivers/ -name "*.ko"` $(TARGET_DIR)/lib/modules/$(LINUX_VERSION)/
	#./depmod.pl -F $(KDIR)/linux-$(LINUX_VERSION)/System.map -b $(TARGET_DIR)/lib/modules/
	#due to depmod can't generate file at read-only file system, so modify the path that generate file
#ifneq ($($(shell echo CONFIG_BRCMSDK$(CONFIG_BRCM_SDK_VERSION)_ZYXEL)),)
ifneq ($(CONFIG_PACKAGE_zcfg),)
	touch $(TARGET_DIR)/var/modules.dep
	touch $(TARGET_DIR)/var/modules.symbols
	touch $(TARGET_DIR)/var/modules.alias
	ln -fs /var/modules.dep $(TARGET_DIR)/lib/modules/$(LINUX_VERSION)/
	ln -fs /var/modules.symbols $(TARGET_DIR)/lib/modules/$(LINUX_VERSION)/
	ln -fs /var/modules.alias $(TARGET_DIR)/lib/modules/$(LINUX_VERSION)/
endif
	$(RSTRIP) $(TARGET_DIR)/lib/modules/$(LINUX_VERSION)/

	rsync -av $(BCM_BUILD_DIR)/targets/$(BCM_PROFILE)/fs.install/  $(TARGET_DIR)/

ifeq ($(CONFIG_PACKAGE_base-files), )
ifneq ($(CONFIG_PACKAGE_zcfg),)
ifeq ($(CONFIG_BRCM_SDK_VERSION), "416L02A")
	$(CP) $(TOPDIR)/target/linux/brcm963xx/base-files/* $(TARGET_DIR)/
else
	$(CP) $(TOPDIR)/target/linux/brcm963xx/base-files-$(CONFIG_BRCM_SDK_VERSION)/* $(TARGET_DIR)/
endif	
else
	# not select zcfg means want to have Broadcom like firmware.
	$(CP) $(TOPDIR)/target/linux/brcm963xx/base-files-bsp/* $(TARGET_DIR)/
endif
	rm `find $(TARGET_DIR)/ -name ".gitkeep"`
ifeq ($(call qstrip,$(CONFIG_BRCM963xx_SDK_VER_416L04) $(CONFIG_BRCM963xx_SDK_VER_416L05)),)
	ln -sf /lib/public/libcms_boardctl.so $(TARGET_DIR)/lib/libcms_boardctl.so
	ln -sf /lib/public/libcms_msg.so $(TARGET_DIR)/lib/libcms_msg.so
	ln -sf /lib/public/libcms_util.so $(TARGET_DIR)/lib/libcms_util.so
endif
endif
	#Need to strip the rootfs to reduce the image size.
	#Don`t strip $(BCM_BUILD_DIR)/targets/$(BCM_PROFILE)/fs.install when you using "sstrip"
	#It may cause compile error when you compile the second time.
	$(RSTRIP) $(TARGET_DIR)/
	
ifneq ($(CONFIG_DSL_SUPPORT),)
	mkdir -p $(TARGET_DIR)/etc/adsl;cp -av $(BROADCOM_SDK_DIR)/bcmdrivers/broadcom/char/adsl/bcm9$(BRCM_CHIP)/*.bin  $(TARGET_DIR)/etc/adsl
endif
ifeq ($(CONFIG_BRCM_CFE_BOOT_FROM_NAND),y)
	cp $(KDIR)/vmlinux.$(KERNEL_FILE_TYPE) $(TARGET_DIR)
	cp $(BIN_DIR)/brcm-cfe/cfe$(BRCM_CHIP)ram.bin $(TARGET_DIR)/cferam.000
	touch -a -m -t 197001010000.00 $(TARGET_DIR)/cferam.000
endif

	$(call Image/mkfs/prepare/default)
ifneq ($(call qstrip,$(CONFIG_BRCM963xx_SDK_VER_416L04) $(CONFIG_BRCM963xx_SDK_VER_416L05)),)
	#in 416L04,416L05, check if we need to do below action?
	#find $INSTALL_DIR -type f -perm /u=x,g=x,o=x -print |xargs -L1 $EXECSTACK -c 2> /dev/null
endif

endef

define Image/Prepare
	# Using BCM proprietary tool "cmplzma" to compress vmlinux
ifneq ($(call qstrip,$(CONFIG_BRCM963xx_SDK_VER_416L04) $(CONFIG_BRCM963xx_SDK_VER_416L05)),)
	$(HOSTTOOLS_DIR)/cmplzma -k -2 -$(KERNEL_COMPRESSION) $(KDIR)/vmlinux.elf $(KDIR)/vmlinux $(KDIR)/vmlinux.$(KERNEL_FILE_TYPE)
else
	$(HOSTTOOLS_DIR)/cmplzma -k -2 $(KDIR)/vmlinux.elf $(KDIR)/vmlinux $(KDIR)/vmlinux.$(KERNEL_FILE_TYPE)
endif

endef

define Image/Build
	$(call Image/Build/CFE,$(1),$(BCM_BOARD_NAME),$(BRCM_CHIP),$(BOARDNAME))
endef

$(eval $(call BuildImage))
