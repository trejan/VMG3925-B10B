# Put your custom commands here that should be executed once
# the system init finished. By default this file does nothing.

# WAR to correct zyxel init sequence.
sleep 10

process_to_kill="zywifid_run.sh zhttp.sh zywifid zhttpd zcmd ztr69 zupnp zhotplugd esmd"

for process in $process_to_kill; do
	kill -9 $(pidof $process)
done

/etc/init.d/zywifid.sh stop
sleep 2

/etc/init.d/zcmd.sh start
/etc/init.d/zywifid.sh start

# WAR: force re-plug on WAN
wan_port="4"
ssdk_sh debug phy set $wan_port 0 0x800
sleep 1
ssdk_sh debug phy set $wan_port 0 0x9000

exit 0
