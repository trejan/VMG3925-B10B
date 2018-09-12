# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# $Id$
	
include $(TOPDIR)/rules.mk

#These lines concatanate the package name and list the URL location from which the package source code is to be downloaded
PKG_NAME:=call_qcsapi_client
#PKG_VERSION:=36.6.0.11
#PKG_VERSION:=36.7.4.17
PKG_VERSION:=36.7.0.31
PKG_RELEASE:=1
PATCH_DIR:=patches

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
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

define Package/call_qcsapi_client
SECTION:=net
CATEGORY:=Quantenna Packages
TITLE:= Quantenna qcapi client
#DEPENDS:=@TARGET_brcm963xx_fmg3586||TARGET_brcm963xx_fmg3086
DEPENDS:=
endef

define Package/call_qcsapi_client/description
 This package use to control Quantenna 5G WiFi module.
endef

define Build/Prepare
	$(call Build/Prepare/Default)
	$(CP) files/* $(PKG_BUILD_DIR)/
	find $(PKG_BUILD_DIR) -name .svn | $(XARGS) rm -rf
endef

MAKE_FLAGS += \
	TARGET_CFLAGS="$(TARGET_CFLAGS)" 

define Package/call_qcsapi_client/install
	$(INSTALL_DIR) $(1)/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/call_qcsapi_sockrpc $(1)/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/call_qcsapi_raw $(1)/bin/
	$(INSTALL_DIR) $(1)/etc
#	$(INSTALL_DATA) $(PKG_BUILD_DIR)/etc/qcsapi_target_ip.conf $(1)/etc/
	ln -s /var/run/qcsapi_target_ip.conf $(1)/etc/qcsapi_target_ip.conf
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/etc/protocols $(1)/etc/
endef

$(eval $(call BuildPackage,call_qcsapi_client))

