# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# $Id$
	
include $(TOPDIR)/rules.mk

#These lines concatanate the package name and list the URL location from which the package source code is to be downloaded
PKG_NAME:=libqcsapi_client
#PKG_VERSION:=36.6.0.11
#PKG_VERSION:=36.7.4.17
PKG_VERSION:=36.7.0.31
PKG_RELEASE:=1
PATCH_DIR:=patches

PKG_SOURCE:=$(PKG_NAME)_$(PKG_VERSION).tar.bz2
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_URL:=@ZyXEL_SITE/public/Quantenna/network/tools
DL_DIR:=$(TOPDIR)/dl

ifneq ("$(strip $(CONFIG_QTN_SDK_VER))","")
	QVER=
	ifeq ("$(QVER)","37.3.0.25")
		PKG_VERSION=r3.0-$(QVER)
		PKG_SOURCE=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
		PKG_BUILD_DIR=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
	else
		PKG_VERSION=$(QVER)
		PKG_SOURCE=$(PKG_NAME)_$(PKG_VERSION).tar.bz2
		PKG_BUILD_DIR=$(BUILD_DIR)/$(PKG_NAME)_$(PKG_VERSION)
	endif
	PATCH_DIR=patches_$(QVER)
endif


include $(INCLUDE_DIR)/package.mk

define Package/libqcsapi_client
SECTION:=net
CATEGORY:=Quantenna Packages
TITLE:= Quantenna qcapi library
#DEPENDS:=@TARGET_brcm963xx_fmg3586||TARGET_brcm963xx_fmg3086
DEPENDS:=
endef

define Package/libqcsapi_client/description
 This library use to control Quantenna 5G WiFi module.
endef


MAKE_FLAGS += \
	TARGET_CFLAGS="$(TARGET_CFLAGS)" 

#Disable Dependencies Check
define CheckDependencies
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include/$(PKG_NAME)
#	$(CP) $(PKG_BUILD_DIR)/*.h $(1)/usr/include/$(PKG_NAME)
#	$(CP) -r $(PKG_BUILD_DIR)/common $(1)/usr/include/$(PKG_NAME)
#	$(CP) -r $(PKG_BUILD_DIR)/qtn $(1)/usr/include/$(PKG_NAME)
#	$(CP) -r $(PKG_BUILD_DIR)/net80211 $(1)/usr/include/$(PKG_NAME)
	rsync -avz --files-from=<(find $(PKG_BUILD_DIR) -name "*.h" -printf "%P\n") $(PKG_BUILD_DIR) $(1)/usr/include/$(PKG_NAME)
	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/libqcsapi_client.so $(1)/usr/lib/
	ln -fs libqcsapi_client.so $(1)/usr/lib/libqcsapi_client.so.1
	ln -fs libqcsapi_client.so $(1)/usr/lib/libqcsapi_client.so.1.0.1
endef

define Package/libqcsapi_client/install
	$(INSTALL_DIR) $(1)/lib
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/libqcsapi_client.so $(1)/lib/
	ln -fs libqcsapi_client.so $(1)/lib/libqcsapi_client.so.1
	ln -fs libqcsapi_client.so $(1)/lib/libqcsapi_client.so.1.0.1
	$(INSTALL_DIR) $(1)/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/qcsapi_sockrpc $(1)/bin/
endef

$(eval $(call BuildPackage,libqcsapi_client))

