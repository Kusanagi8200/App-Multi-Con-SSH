#!/bin/bash

declare -A SERVERS
declare -a SERVER_KEYS

SERVER_KEYS[1]="Stack-API"
SERVER_KEYS[2]="Samba-AD"
SERVER_KEYS[3]="Yunohost"
SERVER_KEYS[4]="Freelab.fun"

SERVERS["Stack-API"]="root@192.168.201.132  "
SERVERS["Samba-AD"]="root@192.168.201.141   "
SERVERS["Yunohost"]="root@192.168.201.146   "
SERVERS["Freelab.fun"]="root@91.234.194.49  "

echo #

function show_menu {
    echo -e "\e[30;43m__________CONNEXIONS SSH____________\e[0m"
    echo #
    for idx in "${!SERVER_KEYS[@]}"; do
        key="${SERVER_KEYS[$idx]}"
        echo -e "\e[97;45m$idx) $key: ${SERVERS[$key]}\e[0m"
        echo # 
    done
    echo -e "\e[30;43m0) FOR QUIT_________________________\e[0m"
    echo #
}

while true; do
    show_menu
    read -p $'\e[30;43m______________________SELECTION = \e[0m ' choice
    if [ "$choice" == "0" ]; then
        exit 0
    elif [ -n "${SERVERS[${SERVER_KEYS[$choice]}]}" ]; then
        echo "CONNEXION EN COURS À ${SERVER_KEYS[$choice]}..."
        ssh "${SERVERS[${SERVER_KEYS[$choice]}]}"
    else
        echo -e "\e[1;31;47mCHOIX NON VALIDE_________________\e[0m"
    fi
done

