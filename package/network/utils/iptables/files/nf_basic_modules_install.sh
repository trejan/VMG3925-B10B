#!/bin/sh

#In Linux kernel v2.6.36 defconfig of Econet, following kernel modules are built-in.

if grep -q '3.4.11' /proc/version && echo $?; then
#nat basic modules
insmod /lib/modules/3.4.11/nf_conntrack.ko
insmod /lib/modules/3.4.11/nf_defrag_ipv4.ko
insmod /lib/modules/3.4.11/nf_conntrack_ipv4.ko
insmod /lib/modules/3.4.11/nf_nat.ko

#iptables basic modules
insmod /lib/modules/3.4.11/ip_tables.ko
insmod /lib/modules/3.4.11/iptable_nat.ko
insmod /lib/modules/3.4.11/iptable_filter.ko
insmod /lib/modules/3.4.11/iptable_mangle.ko
insmod /lib/modules/3.4.11/ipt_MASQUERADE.ko
fi