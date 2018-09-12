#
# Copyright (C) 2006-2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=samba
PKG_VERSION:=3.0.37
PKG_RELEASE:=1

PKG_SOURCE_URL:=@ZyXEL_SITE/opensource/network/services

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz

PKG_INSTALL:=1
PATCH_DIR=patches_${PKG_VERSION}

include $(INCLUDE_DIR)/package.mk

MAKE_PATH:=source
CONFIGURE_PATH:=source
PKG_BUILD_BIN:=$(PKG_BUILD_DIR)/$(MAKE_PATH)/bin

define Package/samba
  SECTION:=net
  CATEGORY:=Network
  TITLE:=samba - NetBIOS/SMB implementation
#  URL:=
endef

define Package/samba/description
	The Samba software suite is a collection of programs that implements the
	SMB protocol for unix systems, allowing you to serve files and printers to
	Windows, NT, OS/2 and DOS clients. This protocol is sometimes also referred
	to as the LanManager or Netbios protocol.
endef

#Disable Dependencies Check
define CheckDependencies
endef

CONFIGURE_VARS+= \
	SMB_BUILD_CC_NEGATIVE_ENUM_VALUES=yes \
	samba_cv_USE_SETEUID=no \
	samba_cv_have_setresuid=yes \
	samba_cv_USE_SETRESUID=yes \
	samba_cv_HAVE_C99_VSNPRINTF=yes \
	samba_cv_have_longlong=yes \
	ac_cv_type_long_long=yes \
	samba_cv_HAVE_KERNEL_OPLOCKS_LINUX=yes
	
CONFIGURE_ARGS+= \
	--with-configdir=/etc/samba \
	--with-codepagedir=/var/samba \
	--with-configdir=/var/samba \
	--with-included-iniparser \
	--with-included-popt \
	--with-lockdir=/var/lock \
	--with-logfilebase=/var/log \
	--with-nmbdsocketdir=/var/samba/nmbd \
	--with-piddir=/var/run \
	--with-privatedir=/var/samba \
	--with-aio-support \
	--with-sendfile-support \
	--with-sys-quotas=no \
	--enable-cups=no \
	--enable-iprint=no \
	--enable-largefile \
	--without-krb5 \
	--without-ads \
	--without-ldap \
	--without-pam \
	--without-winbind \
	--without-libtdb \
	--without-libtalloc \
	--without-libnetapi \
	--without-libsmbclient \
	--without-libsmbsharemodes \
	--without-libaddns 
	
ZCFLAGS += -DZYXEL_PATCH
	
TARGET_CFLAGS += -DAVM_SMALLER -DAVM_NO_PRINTING -DMAX_DEBUG_LEVEL=2 $(ZCFLAGS)
	
MAKE_FLAGS += OWRT_NO_PRINTING=1 OWRT_SMALLER=1

# define Build/Compile
	# $(MAKE) -C $(PKG_BUILD_DIR)/source
# endef

define Package/samba/install
	$(INSTALL_DIR) $(1)/var/samba
	$(INSTALL_DIR) $(1)/var/samba/nmbd
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/$(MAKE_PATH)/codepages/lowcase.dat $(1)/var/samba
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/$(MAKE_PATH)/codepages/upcase.dat $(1)/var/samba
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/$(MAKE_PATH)/codepages/valid.dat $(1)/var/samba
	$(INSTALL_DIR) $(1)/usr/lib
#	$(INSTALL_BIN) $(PKG_BUILD_BIN)/libtalloc.so.1 $(1)/usr/lib
#	$(INSTALL_BIN) $(PKG_BUILD_BIN)/libtdb.so.1 $(1)/usr/lib
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_BIN)/smbpasswd $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_BIN)/smbd $(1)/usr/sbin/
	$(STRIP) $(1)/usr/sbin/smbpasswd
	$(STRIP) $(1)/usr/sbin/smbd
endef

$(eval $(call BuildPackage,samba))
