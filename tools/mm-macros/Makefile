#
# Copyright (C) 2010-2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=mm-macros
PKG_VERSION:=0.9.5

#PKG_SOURCE_URL:=http://ftp.gnome.org/pub/GNOME/sources/mm-common/0.9
PKG_SOURCE:=mm-common-$(PKG_VERSION).tar.bz2
PKG_MD5SUM:=4a4dad67fc8d7e0c529f3a8c6ba4d8b2
PKG_SOURCE_URL:=@ZyXEL_SITE/opensource/tools

HOST_BUILD_DIR:=$(BUILD_DIR_HOST)/mm-common-$(PKG_VERSION)

include $(INCLUDE_DIR)/host-build.mk

define Host/Install
	$(INSTALL_DIR) $(STAGING_DIR_HOST)/share/aclocal
	$(INSTALL_DATA) $(HOST_BUILD_DIR)/macros/*.m4 $(STAGING_DIR_HOST)/share/aclocal/
endef

define Host/Clean
	-$(MAKE) -C $(HOST_BUILD_DIR) uninstall
	$(call Host/Clean/Default)
endef

$(eval $(call HostBuild))
