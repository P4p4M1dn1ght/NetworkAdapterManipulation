#!/bin/bash
select configs in default_monitor airmon_monitor washed_out default_shutdown airmon_shutdown broken_network_fix
do
	case $configs in
		default_monitor )
			for command in ifconfig
			do
				$command wlan1 down

			done

			for command in iwconfig
			do
				$command wlan1 mode monitor

			done

			for command in ifconfig
			do
				$command wlan1 up

			done

			for command in proxychains4
			do
				$command airodump-ng wlan1

			done ;;

		airmon_monitor )
			for command in airmon-ng
			do
				$command check kill && $command start wlan1

			done

			for command in proxychains4
			do
				$command airodump-ng wlan1

			done ;;

		washed_out )
			for command in proxychains4
			do
				$command wash -i wlan1

			done ;;

		default_shutdown )
			for command in ifconfig
			do
				$command wlan1 down

			done

			for command in iwconfig
			do
				$command wlan1 mode managed

			done

			for command in ifconfig
			do
				$command wlan1 up 

			done ;;


		airmon_shutdown )
			for command in airmon-ng
			do
				$command stop wlan1

			done

			for command in ifconfig
			do
				$command wlan1 down

			done

			for command in iwconfig
			do
				$command wlan1 mode managed

			done

			for command in ifconfig
			do
				$command wlan1 up && ./Networkrestarter.sh

			done ;;

		broken_network_fix )
			ifconfig wlan1 down && iwconfig wlan1 mode managed && ifconfig wlan1 up && service NetworkManager restart ;;

		* )
			echo "Try again!!" ;;

	esac

done


#Scripted by:~ P4p4M1dn1ght
