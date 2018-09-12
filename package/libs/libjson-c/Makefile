#
# Copyright (C) 2006-2010 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=json-c
PKG_VERSION:=0.12
PKG_RELEASE:=2

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
#PKG_SOURCE_URL:=http://oss.metaparadigm.com/json-c/
PKG_SOURCE_URL:=@ZyXEL_SITE/opensource/libs

PATCH_DIR:=patches-$(PKG_VERSION)

ifeq ($(strip $(CONFIG_BRCM_SDK_VERSION)),"416L04")
	PKG_VERSION=0.12
	PATCH_DIR=patches-$(PKG_VERSION)
	PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
endif

PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=COPYING

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

PKG_MAINTAINER:=Felix Fietkau <nbd@openwrt.org>

include $(INCLUDE_DIR)/package.mk
TARGET_CFLAGS += $(FPIC)
#TARGET_CFLAGS += $(FPIC) -Wno-error=unused-but-set-variable
ifeq ("$(strip ${ZCFG_PLATFORM})","BROADCOM")
TARGET_CFLAGS += -Wno-error=unused-but-set-variable
endif

define Package/libjson
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=javascript object notation
endef

define Package/libjson/description
 This package contains a library for javascript object notation backends.
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include
	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig
ifeq ($(shell test $(shell echo $(PKG_VERSION) | cut -d . -f 2) -gt 11; echo $$?),0)
	$(CP) $(PKG_INSTALL_DIR)/usr/include/json-c $(1)/usr/include/
	ln -s json-c $(1)/usr/include/json
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libjson-c.{a,so*} $(1)/usr/lib/
	ln -s libjson-c.so $(1)/usr/lib/libjson.so
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/json-c.pc $(1)/usr/lib/pkgconfig/
else
	$(CP) $(PKG_INSTALL_DIR)/usr/include/json $(1)/usr/include/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libjson.{a,so*} $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/json.pc $(1)/usr/lib/pkgconfig/
endif	
	
endef

define Package/libjson/install
	$(INSTALL_DIR) $(1)/usr/lib
ifeq ($(shell test $(shell echo $(PKG_VERSION) | cut -d . -f 2) -gt 11; echo $$?),0)
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libjson-c.so* $(1)/usr/lib/
	ln -s libjson-c.so $(1)/usr/lib/libjson.so
else	
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libjson.so* $(1)/usr/lib/
endif

endef

$(eval $(call BuildPackage,libjson))
