# 
# Copyright (C) 2006 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

PKG_NAME:=autoconf
PKG_VERSION:=2.68

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
#PKG_SOURCE_URL:=@GNU/autoconf
PKG_MD5SUM:=864d785215aa60d627c91fcb21b05b07
PKG_SOURCE_URL:=@ZyXEL_SITE/opensource/tools

include $(INCLUDE_DIR)/host-build.mk

define Host/Configure
	$(call Host/Configure/Default,\
		--datarootdir=$(STAGING_DIR_HOST)/share \
	)
endef

define Host/Compile
	export SHELL="$(BASH)"; $(MAKE) -C $(HOST_BUILD_DIR)
endef

define Host/Install
	export SHELL="$(BASH)"; $(MAKE) -C $(HOST_BUILD_DIR) install
endef

define Host/Clean
	-export SHELL="$(BASH)"; $(MAKE) -C $(HOST_BUILD_DIR) uninstall
	$(call Host/Clean/Default)
endef

$(eval $(call HostBuild))
