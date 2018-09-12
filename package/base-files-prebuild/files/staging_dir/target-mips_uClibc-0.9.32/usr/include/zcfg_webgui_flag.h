
/* Flag1 */
#define HIDE_VOIP						(1 << 0)
#define HIDE_DECT						(1 << 1)
#define HIDE_ETH_WAN_TAB				(1 << 2)
#define HIDE_WLAN_PASSPHRASE			(1 << 3) 
#define SHOW_CONFIG_VOIP_COMFORT_NOISE	(1 << 4) //16 , add for SuperOnLine (SOL) project customize, they want to config silence suppression and comfortnoise separately , yushiuan , 2015/02/10.
#define SHOW_ROMD_TAB					(1 << 5)
#define SHOW_USA_PRODUCT_PAGE			(1 << 6)
#define SHOW_RSA_PAGE					(1 << 7)
#define VOICE_CODEC_G729_SUPPORT		(1 << 8)
#define VOICE_CODEC_PRI_G729_FIRST		(1 << 9)
#define HIDE_TR064						(1 << 10)
#define SHOW_DDNS_myzyxel_th			(1 << 11)
#define HIDE_VD_PAGE					(1 << 12)
#define HIDE_VOICE_SRTP					(1 << 13)
#define HIDE_VOICE_IVR					(1 << 14)
#define DEDICATED_ETH_WAN				(1 << 15)
#define SHOW_NOT_USE_OFTEN_VOIP_SETTING	(1 << 16) //65536 , yushiuan add 2015/12/08 , add for hide some function which not used often for voip related page
#define SINGLE_LOGIN					(1 << 17)
#define ELISA_PAGE_CUSTOMIZE			(1 << 18) //262144
#define HIDE_WLAN_WDS					(1 << 19)
#define HIDE_WLAN_CHANNEL_SCAN			(1 << 20)
#define DSL_BONDING						(1 << 21)
#define TURKEY_LOGO						(1 << 22)
#define VOIP_SIP_PHONE_MAPPING_BY_STD_PHY_REFERENCE_LIST		(1<<23) // 8388608
#define HIDE_DSL                                                        (1<<24) // 16777216
#define VOICE_CODEC_G726_SPECIAL_CASE	(1 << 25) //33554432, Michael.20161005.001: add for (a)supporting G726-32 ONLY first now and (b)reserved for some other special G726 codec case(s) in the future.
#define HIDE_WLAN_ENABLE                (1 << 26) //67108864
#define HIDE_WLAN_CHANNEL_1213          (1 << 27) // 134217728
#define HIDE_WLAN_WEP                   (1 << 28) //For Oi product, WEP setting is needed. 
/* End of Flag1*/


