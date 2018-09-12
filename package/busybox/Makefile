# 
# Copyright (C) 2006-2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=busybox
PKG_VERSION:=1_20_1
PKG_RELEASE:=5
PKG_FLAGS:=essential

#PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
#PKG_SOURCE_URL:=http://www.busybox.net/downloads \
		http://distfiles.gentoo.org/distfiles/
#PKG_MD5SUM:=9c0cae5a0379228e7b55e5b29528df8e
PKG_SOURCE_URL:=@ZyXEL_SITE/opensource/utils/busybox
#PKG_SOURCE_URL:=@ZyXEL_SITE/opensource/misc

PKG_BUILD_DEPENDS:=BUSYBOX_CONFIG_FEATURE_HAVE_RPC:librpc
PKG_BUILD_DEPENDS+=PACKAGE_zcmd:zcfg PACKAGE_zcmd:libzcfg_msg PACKAGE_zcmd:libjson PACKAGE_zcmd:libzcfg_fe_rdm_access PACKAGE_zcmd:libzcmd_tool PACKAGE_zcmd:libzcfg_fe_rdm_struct
PKG_BUILD_PARALLEL:=1

PKG_LICENSE:=GPLv2 BSD-4c
PKG_LICENSE_FILES:=LICENSE archival/libarchive/bz/LICENSE

include $(INCLUDE_DIR)/package.mk

# __ZYXEL__start,
# Replace 'CONFIG_ECONETSDK_' for menuconfig only supports a single prompt problem.
ifeq ("$(strip ${ZCFG_PLATFORM})","ECONET")
PLATFORM_PREFIX=CONFIG_$(call qstrip, $(CONFIG_CUSTOM_SDK_PREFIX))_
endif
ifneq ($(strip $(PLATFORM_PREFIX)),)
$(foreach v, \
        $(shell grep "^$(PLATFORM_PREFIX)" $(TOPDIR)/.config), \
        $(eval $(shell echo $v|sed "s/$(PLATFORM_PREFIX)//"|cut -d'=' -f1)=$(shell echo $v|cut -d'=' -f2)))
endif
# __ZYXEL__end

ifeq ($(DUMP),)
  STAMP_CONFIGURED:=$(strip $(STAMP_CONFIGURED))_$(shell $(SH_FUNC) grep '^CONFIG_BUSYBOX_' $(TOPDIR)/.config | md5s)
endif

ifneq ($(findstring c,$(OPENWRT_VERBOSE)),)
  BB_MAKE_VERBOSE := V=1
else
  BB_MAKE_VERBOSE :=
endif

init-y :=
init-$(CONFIG_BUSYBOX_CONFIG_CROND) += cron
init-$(CONFIG_BUSYBOX_CONFIG_TELNETD) += telnet

#ifeq ($(CONFIG_PACKAGE_zcmd),y)
#ZCFG_DEP= +zcfg +libzcfg_msg +libzcfg_fe_rdm_struct +libjson
#ZCFG_DEP=+libzcfg_fe_rdm_struct
#endif


define Package/busybox
  SECTION:=base
  CATEGORY:=Base system
  MAINTAINER:=Nicolas Thill <nico@openwrt.org>
  TITLE:=Core utilities for embedded Linux
  URL:=http://busybox.net/
  DEPENDS:=+BUSYBOX_CONFIG_FEATURE_HAVE_RPC:librpc $(ZCFG_DEP)
  MENU:=1
endef

define Package/busybox/config
	select PACKAGE_libzcfg_fe_rdm_struct if PACKAGE_zcfg
	select PACKAGE_libzcfg_msg if PACKAGE_zcfg
	select PACKAGE_libjson if PACKAGE_zcfg
endef
#Disable Dependencies Check
define CheckDependencies
endef

define Package/busybox/description
 The Swiss Army Knife of embedded Linux.
 It slices, it dices, it makes Julian Fries.
endef

define Package/busybox/config
	source "$(SOURCE)/Config.in"
endef

define Build/Configure
	rm -f $(PKG_BUILD_DIR)/.configured*
	grep 'CONFIG_BUSYBOX_' $(TOPDIR)/.config | sed -e "s,\\(# \)\\?CONFIG_BUSYBOX_\\(.*\\),\\1\\2,g" > $(PKG_BUILD_DIR)/.config
	yes '' | $(MAKE) -C $(PKG_BUILD_DIR) \
		CC="$(TARGET_CC)" \
		CROSS_COMPILE="$(TARGET_CROSS)" \
		KBUILD_HAVE_NLS=no \
		ARCH="$(ARCH)" \
		$(BB_MAKE_VERBOSE) \
		oldconfig
endef

ifdef CONFIG_GCC_VERSION_LLVM
  TARGET_CFLAGS += -fnested-functions
endif

LDLIBS:=m crypt
ifdef CONFIG_BUSYBOX_CONFIG_FEATURE_HAVE_RPC
  TARGET_CFLAGS += -I$(STAGING_DIR)/usr/include
  export LDFLAGS=$(TARGET_LDFLAGS)
  LDLIBS += rpc
endif

ifeq ($(CONFIG_BRCM_SDK_VERSION), "412L08")
#TARGET_CFLAGS += -DBRCM_SDK_412L08
TARGET_CFLAGS += -DBRCM_CHANGE
endif

ifeq ($(CONFIG_BRCM_SDK_VERSION), "414L04")
#TARGET_CFLAGS += -DBRCM_SDK_414L04
TARGET_CFLAGS += -DBRCM_CHANGE
endif

ifeq ($(CONFIG_PACKAGE_zcmd),y)
TARGET_CFLAGS += -DZCFG_SUPPORT
LDLIBS += json zcfg_msg zcfg_fe_rdm_access zcmd_tool zcfg_fe_rdm_struct
endif

ifeq ($(TCSUPPORT_WAN_GPON),y)
TARGET_CFLAGS += -DTCSUPPORT_WAN_GPON
endif

ifneq ($(strip ${ZCFG_PLATFORM}),)
TARGET_CFLAGS += -DPLATFORM_$(ZCFG_PLATFORM)
endif

ifeq ($(CONFIG_ZYXEL_SAVE_LOG_TO_FLASH),y)
TARGET_CFLAGS += -DZYXEL_SAVE_LOG_TO_FLASH
endif

ifeq ($(CONFIG_ZYXEL_DL_DIAG_CALCULATION),y)
TARGET_CFLAGS += -DZYXEL_DL_DIAG_CALCULATION
endif

ifeq ($(CONFIG_CBT_CUSTOMIZATION),y)
TARGET_CFLAGS += -DCBT_CUSTOMIZATION
endif
ifeq ($(CONFIG_ZYXEL_NAT_LOG),y)
TARGET_CFLAGS += -DZYXEL_NAT_LOG
endif
define Build/Compile
	+$(MAKE) $(PKG_JOBS) -C $(PKG_BUILD_DIR) \
		CC="$(TARGET_CC)" \
		CROSS_COMPILE="$(TARGET_CROSS)" \
		KBUILD_HAVE_NLS=no \
		EXTRA_CFLAGS="$(TARGET_CFLAGS)" \
		ARCH="$(ARCH)" \
		SKIP_STRIP=y \
		LDLIBS="$(LDLIBS)" \
		$(BB_MAKE_VERBOSE) \
		all
	rm -rf $(PKG_INSTALL_DIR)
	$(FIND) $(PKG_BUILD_DIR) -lname "*busybox" -exec rm \{\} \;
	$(MAKE) -C $(PKG_BUILD_DIR) \
		CC="$(TARGET_CC)" \
		CROSS_COMPILE="$(TARGET_CROSS)" \
		EXTRA_CFLAGS="$(TARGET_CFLAGS)" \
		ARCH="$(ARCH)" \
		CONFIG_PREFIX="$(PKG_INSTALL_DIR)" \
		LDLIBS="$(LDLIBS)" \
		$(BB_MAKE_VERBOSE) \
		install
endef

define Package/busybox/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(CP) $(PKG_INSTALL_DIR)/* $(1)/
	for tmp in $(init-y); do \
		$(INSTALL_BIN) ./files/$$$$tmp $(1)/etc/init.d/$$$$tmp; \
	done
	-rm -rf $(1)/lib64
ifdef CONFIG_BUSYBOX_CONFIG_PING
	chmod 4777 $(1)/bin/ping
endif
endef

$(eval $(call BuildPackage,busybox))
