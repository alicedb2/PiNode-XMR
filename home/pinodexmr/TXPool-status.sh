#!/bin/sh
#Establish IP/Port
DEVICE_IP="$(hostname -I | awk '{print $1}')"
#Import Start Flag Values:
	#Load boot status - what condition was node last run
	. /home/pinodexmr/bootstatus.sh
	#Import Un-restricted Port Number (for internal status updates)
	. /home/pinodexmr/monero-stats-port.sh
	#Import Restricted Port Number (external use)
	. /home/pinodexmr/monero-port.sh
	#Import RPC username
	. /home/pinodexmr/RPCu.sh
	#Import RPC password
	. /home/pinodexmr/RPCp.sh
	
	if [ $BOOT_STATUS -eq 2 ]
then	
		#System Idle
		echo "--System Idle--" > /var/www/html/TXPool_Status.txt
fi	
	
	if [ $BOOT_STATUS -eq 3 ] || [ $BOOT_STATUS -eq 4 ] || [ $BOOT_STATUS -eq 5 ]
then	
		#Node Status
		PRINT_POOL_STATS="$(./monero/build/release/bin/monerod --rpc-bind-ip=${DEVICE_IP} --rpc-bind-port=${MONERO_PORT} --rpc-login=${RPCu}:${RPCp} --rpc-ssl disabled print_pool_stats | sed '1d')" && echo "$PRINT_POOL_STATS" > /var/www/html/TXPool_Status.txt
fi	
	
	if [ $BOOT_STATUS -eq 6 ]
then
		#Adapted command for restricted public rpc calls (payments)
		PRINT_POOL_STATS="$(./monero/build/release/bin/monerod --rpc-bind-ip=$DEVICE_IP --rpc-bind-port=$MONERO_STATS_PORT --rpc-ssl disabled print_pool_stats | sed '1d')" && echo "$PRINT_POOL_STATS" > /var/www/html/TXPool_Status.txt
fi

	if [ $BOOT_STATUS -eq 7 ]
then
		#Adapted command for public free (restricted) rpc calls. No auth needed for local.
		PRINT_POOL_STATS="$(./monero/build/release/bin/monerod --rpc-bind-ip=$DEVICE_IP --rpc-bind-port=$MONERO_PORT --rpc-ssl disabled print_pool_stats | sed '1d')" && echo "$PRINT_POOL_STATS" > /var/www/html/TXPool_Status.txt
fi
