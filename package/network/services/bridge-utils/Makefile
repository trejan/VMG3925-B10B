# 
# Copyright (C) 2006-2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=bridge
PKG_RELEASE:=1
PKG_BUILD_DEPENDS:=opkg/host
#PKG_SOURCE_URL:=@SF/bridge
PKG_SOURCE_URL:=@ZyXEL_SITE/opensource/network/utils

ZCFLAGS:= 
#ifneq ($(CONFIG_TARGET_mt75xx),)
ifeq ("$(strip ${ZCFG_PLATFORM})","ECONET")
PKG_VERSION:=1.0.6
else
#PKG_VERSION:=1.2
PKG_VERSION:=1.5
endif

#PKG_MD5SUM:=ec7b381160b340648dede58c31bb2238
PATCH_DIR:=patches-$(PKG_VERSION)/$(ZCFG_PLATFORM)
PKG_BUILD_DIR:=$(BUILD_DIR)/bridge-utils-$(PKG_VERSION)
PKG_SOURCE:=bridge-utils-$(PKG_VERSION).tar.gz

include $(INCLUDE_DIR)/package.mk

define Package/bridge
  SECTION:=net
  CATEGORY:=Base system
  TITLE:=Ethernet bridging configuration utility
  URL:=http://bridge.sourceforge.net/
endef

define Package/bridge/description
 Manage ethernet bridging: a way to connect networks together to 
 form a larger network.
endef

ifeq ("$(strip ${ZCFG_PLATFORM})","ECONET")
ifneq ($(strip $(CONFIG_$(subst $\",,$(CONFIG_CUSTOM_SDK_PREFIX))_TCSUPPORT_IGMP_SNOOPING)),)
ZCFLAGS += -DTCSUPPORT_IGMP_SNOOPING -DCONFIG_IGMP_SNOOPING -DCONFIG_BRIDGE_IGMP_SNOOPING
endif
ifneq ($(strip $(CONFIG_$(subst $\",,$(CONFIG_CUSTOM_SDK_PREFIX))_TCSUPPORT_IGMP_SNOOPING_V3)),)
ZCFLAGS += -DTCSUPPORT_IGMP_SNOOPING_V3
endif
ifneq ($(strip $(CONFIG_$(subst $\",,$(CONFIG_CUSTOM_SDK_PREFIX))_TCSUPPORT_IGMPSNOOPING_ENHANCE)),)
ZCFLAGS += -DTCSUPPORT_IGMPSNOOPING_ENHANCE
endif
ifneq ($(strip $(CONFIG_$(subst $\",,$(CONFIG_CUSTOM_SDK_PREFIX))_TCSUPPORT_MLD_SNOOPING)),)
ZCFLAGS += -DTCSUPPORT_MLD_SNOOPING -DCONFIG_MLD_SNOOPING
endif
ifneq ($(strip $(CONFIG_$(subst $\",,$(CONFIG_CUSTOM_SDK_PREFIX))_TCSUPPORT_OMCI)),)
ZCFLAGS += -DTCSUPPORT_OMCI
endif
endif

ifeq ("$(strip ${ZCFG_PLATFORM})","BROADCOM")
ifneq ($(strip $(CONFIG_BRCMSDK$(subst $\",,$(CONFIG_BRCM_SDK_VERSION))_BUILD_VLAN_AGGR)),)
ZCFLAGS += -DCONFIG_BCM_VLAN_AGGREGATION -DCONFIG_BCM_KF_VLAN_AGGREGATION
endif
ifeq ("$(strip ${BRCM_SDK_VERSION})","416L04")
ZCFLAGS += -DBRCM_SDK_${BRCM_SDK_VERSION}
endif
ifeq ("$(strip ${BRCM_SDK_VERSION})","416L05")
ZCFLAGS += -DBRCM_SDK_${BRCM_SDK_VERSION}
endif
endif

ZCFLAGS += -DPLATFORM_$(ZCFG_PLATFORM)


ifneq ($(strip $(CONFIG_PACKAGE_zcfg)),)
ZCFLAGS += -DZCFG_USED -DZYXEL_PATCH
endif

TARGET_CFLAGS += $(ZCFLAGS)

CONFIGURE_ARGS += \
	--with-linux-headers="$(LINUX_DIR)/include" \
	
define Build/Prepare
$(call Build/Prepare/Default)
	( cd $(PKG_BUILD_DIR) ; \
		[ -f ./configure ] || { \
			ln -sf configure.in configure.ac ; \
			autoconf ; \
		} \
	)
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_BUILD_DIR)/libbridge/libbridge.h $(1)/usr/include/
#ifneq ($(CONFIG_TARGET_mt75xx),)
ifeq ("$(strip ${ZCFG_PLATFORM})","ECONET")
	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/libbridge/libbridge.a $(1)/usr/lib
endif
endef

define Package/bridge/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/brctl/brctl $(1)/usr/sbin
endef

$(eval $(call BuildPackage,bridge))
