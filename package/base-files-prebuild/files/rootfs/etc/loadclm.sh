#!/bin/sh
BCM43664_CHIP_ID="aa90" # 43664 in dec mode
BCM4366_CHIP_ID="4366"
BCM43602_CHIP_ID="aa52"
CLM_PATH="/etc/wlan/clm"
wlans="$(ifconfig -a | grep -o "wl[0-9]\+")";
for intf in ${wlans}; do
   chip_id="$(wlctl -i ${intf} revinfo | grep "chipnum 0x")"
   chip_id=${chip_id/chipnum 0x/}
   # if [[ ${chip_id:0:1} == "a" ]] ; then chip_id="$((16#$chip_id))"; fi
    
   case "${chip_id}" in
        ${BCM43664_CHIP_ID})
                chip_id="4366"
                blob="${CLM_PATH}/${chip_id}_access.clm_blob"
                if [ -e ${blob} ] ; then 
                   echo "$0: Download ${blob} to ${intf}"
                   wlctl -i ${intf} clmload ${blob}
                else
                   echo "Skip $0: ${blob} doesn't exist"
                fi
                ;;
        ${BCM4366_CHIP_ID})
                blob="${CLM_PATH}/${chip_id}_access.clm_blob"
                if [ -e ${blob} ] ; then 
                   echo "$0: Download ${blob} to ${intf}"
                   wlctl -i ${intf} clmload ${blob}
                else
                   echo "Skip $0: ${blob} doesn't exist"
                fi
                ;;
        ${BCM43602_CHIP_ID})
                blob="${CLM_PATH}/43602a1_access.clm_blob"
                if [ -e ${blob} ] ; then 
                   echo "$0: Download ${blob} to ${intf}"
                   wlctl -i ${intf} clmload ${blob}
                else
                   echo "Skip $0: ${blob} doesn't exist"
                fi
                ;;

        *)
                blob="${CLM_PATH}/router.clm_blob"
                if [ -e ${blob} ] ; then 
                   echo "$0: Download ${blob} to ${intf}"
                   wlctl -i ${intf} clmload ${blob}
                else
                   echo "Skip $0: ${blob} doesn't exist"
                fi
                ;;

   esac
done
