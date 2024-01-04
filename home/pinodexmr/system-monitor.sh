#!/bin/sh

(
	echo -n "This report generated " & date;
	echo -n "Status Scripts: " && systemctl status moneroStatus.service | sed -n '3'p | cut -c13-;
	echo -n "Log-io Server: " && systemctl status log-io-server.service | sed -n '3'p | cut -c13-;
	echo -n "Log-io File: " && systemctl status log-io-file.service | sed -n '3'p | cut -c13-;
	echo -n "Private Node: " && systemctl status moneroPrivate.service | sed -n '3'p | cut -c13-;
	echo -n "Public  Free: " && systemctl status moneroPublicFree.service | sed -n '3'p | cut -c13-;
	echo -n "Public RPC Pay: " && systemctl status moneroPublicRPCPay.service | sed -n '3'p | cut -c13-;
	echo -n "Mining  Node: " && systemctl status moneroMiningNode.service | sed -n '3'p | cut -c13-;
	echo -n "Tor     Node: " && systemctl status moneroTorPrivate.service | sed -n '3'p | cut -c13-;
	echo -n "Tor Public  : " && systemctl status moneroTorPublic.service | sed -n '3'p | cut -c13-;
	echo -n "I2P     Node: " && systemctl status moneroI2PPrivate.service | sed -n '3'p | cut -c13-;
	echo -n "Custom  Node: " && systemctl status moneroCustomNode.service | sed -n '3'p | cut -c13-;
	echo -n "Explorer    : " && systemctl status blockExplorer.service | sed -n '3'p | cut -c13-;
	echo -n "P2Pool Server: " && systemctl status p2pool.service | sed -n '3'p | cut -c13-;
	echo -n "Monero-LWS  : " && systemctl status monero-lws.service | sed -n '3'p | cut -c13-;
	echo -n "Atomic Swap  : " && systemctl status atomic-swap.service | sed -n '3'p | cut -c13-;
	) > /var/www/html/iamrunning_version.txt