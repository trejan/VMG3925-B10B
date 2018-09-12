#
# Copyright (C) 2006-2010 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libsrtp
PKG_VERSION:=1.4.2
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
#PKG_SOURCE_URL:=http://oss.metaparadigm.com/json-c/
PKG_SOURCE_URL:=@ZyXEL_SITE/opensource/libs

PKG_LICENSE:=BSD
PKG_LICENSE_FILES:=LICENSE

#PKG_FIXUP:=autoreconf
#PKG_INSTALL:=1

PKG_MAINTAINER:=David A. McGrew <mcgrew@cisco.com>

include $(INCLUDE_DIR)/package.mk

TARGET_CFLAGS += $(FPIC)

define Package/libsrtp
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=SRTP Library
endef


define Package/libsrtp/description
 This package contains a library for SRTP.
endef


define Build/Compile
        $(MAKE) -C $(PKG_BUILD_DIR)
endef


### Michael.20150318.002: Modify to change the Voice/VoIP-related OpenWRT-based Common Reference Resources (Header file + Library) Install Path/Directory.
#define Build/InstallDev
#	$(INSTALL_DIR) $(STAGING_DIR)/usr/include/libsrtp/include
#	$(INSTALL_DIR) $(STAGING_DIR)/usr/include/libsrtp/crypto/include
#	
#	$(CP) $(PKG_BUILD_DIR)/include/*.h  $(STAGING_DIR)/usr/include/libsrtp/include
#	$(CP) $(PKG_BUILD_DIR)/crypto/include/*.h  $(STAGING_DIR)/usr/include/libsrtp/crypto/include
#endef
define Build/InstallDev
	$(INSTALL_DIR) $(STAGING_DIR)/usr/include/voice/srtp
	$(CP) $(PKG_BUILD_DIR)/include/*.h  $(STAGING_DIR)/usr/include/voice/srtp/

	$(INSTALL_DIR) $(STAGING_DIR)/usr/include/voice/srtp/crypto
	$(CP) $(PKG_BUILD_DIR)/crypto/include/*.h  $(STAGING_DIR)/usr/include/voice/srtp/crypto/
endef


### Michael.20150318.002: Modify to change the Voice/VoIP-related OpenWRT-based Common Reference Resources (Header file + Library) Install Path/Directory.
#define Package/libsrtp/install
#	$(CP) $(PKG_BUILD_DIR)/libsrtp.a  $(STAGING_DIR)/usr/lib/
#endef
define Package/libsrtp/install
	$(CP) $(PKG_BUILD_DIR)/libsrtp.a  $(STAGING_DIR)/usr/lib/voice/
endef


$(eval $(call BuildPackage,libsrtp))
