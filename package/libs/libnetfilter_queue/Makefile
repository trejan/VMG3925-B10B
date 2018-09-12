#
# Copyright (C) 2007-2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libnetfilter_queue
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=@ZyXEL_SITE/opensource/libs
#PKG_SOURCE_URL:= \
	http://www.netfilter.org/projects/libnetfilter_queue/files \
	ftp://ftp.netfilter.org/pub/libnetfilter_queue/ 

PKG_MD5SUM:=af6a9ea350f63a13609bc3b47b5c395c
PKG_MAINTAINER:=Jo-Philipp Wich <jow@openwrt.org>

PKG_FIXUP:=autoreconf

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=A userspace library providing an API to packets that have been queued by the kernel packet filter
  URL:=http://netfilter.org/projects/libnetfilter_queue/
  DEPENDS:=+libnfnetlink
endef

define Package/$(PKG_NAME)/description
 libnetfilter_queue is a userspace library providing an API to packets that have been queued by the kernel
 packet filter. It is is part of a system that deprecates the old ip_queue / libipq mechanism.
 libnetfilter_queue has been previously known as libnfnetlink_queue
endef

TARGET_CFLAGS += $(FPIC)

CONFIGURE_ARGS += \
	--enable-static \
	--enable-shared

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include/$(PKG_NAME)
	$(CP) $(PKG_INSTALL_DIR)/usr/include/$(PKG_NAME)/*.h  $(1)/usr/include/$(PKG_NAME)
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/lib/$(PKG_NAME).{a,so*} \
		$(1)/usr/lib/
	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/lib/pkgconfig/$(PKG_NAME).pc \
		$(1)/usr/lib/pkgconfig/
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/lib/$(PKG_NAME).so* \
		$(1)/usr/lib/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
