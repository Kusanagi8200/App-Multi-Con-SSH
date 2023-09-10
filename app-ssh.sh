#!/bin/bash

declare -A SERVERS
declare -a SERVER_KEYS

SERVER_KEYS[1]="Stack-API"
SERVER_KEYS[2]="Samba-AD"
SERVER_KEYS[3]="Yunohost"
SERVER_KEYS[4]="Freelab.fun"

SERVERS["Stack-API"]="root@192.168.201.132"
SERVERS["Samba-AD"]="root@192.168.201.141"
SERVERS["Yunohost"]="root@192.168.201.146"
SERVERS["Freelab.fun"]="root@91.234.194.49"

function add_new_connection {
    read -p $'\e[34mName of the new connection:\e[0m ' new_name
    read -p $'\e[34mAddress of the new connection (user@ip):\e[0m ' new_address
    
    # Update the arrays with the new connection
    idx=${#SERVER_KEYS[@]}+1
    SERVER_KEYS[$idx]=$new_name
    SERVERS["$new_name"]=$new_address
    
    echo -e "\e[34mNew connection successfully added!\e[0m"
}

function delete_connection {
    echo "List of existing connections:"
    for idx in "${!SERVER_KEYS[@]}"; do
        key="${SERVER_KEYS[$idx]}"
        echo "$idx) $key: ${SERVERS[$key]}"
    done
    read -p $'\e[31mEnter the number of the connection you want to delete:\e[0m ' del_choice

    if [ -n "${SERVER_KEYS[$del_choice]}" ]; then
        unset SERVERS["${SERVER_KEYS[$del_choice]}"]
        SERVER_KEYS=("${SERVER_KEYS[@]:0:$del_choice}" "${SERVER_KEYS[@]:$(($del_choice + 1))}")
        echo -e "\e[31mConnection deleted successfully!\e[0m"
    else
        echo -e "\e[1;31;47mINVALID CHOICE_________________\e[0m"
    fi
}

function show_menu {
    echo -e "\e[30;43m__________SSH CONNECTIONS___________\e[0m"
    echo #
    for idx in "${!SERVER_KEYS[@]}"; do
        key="${SERVER_KEYS[$idx]}"
        echo -e "\e[97;45m$idx) $key: ${SERVERS[$key]}\e[0m"
        echo #
    done
    echo -e "\e[30;43m0) EXIT_____________________________\e[0m"
    echo # 
    echo -e "\e[30;43m+) ADD A NEW CONNECTION_____________\e[0m"
    echo #
    echo -e "\e[30;43m-) DELETE A CONNECTION______________\e[0m"
    echo #
}

while true; do
    show_menu
    read -p $'\e[30;43m______________________SELECTION = \e[0m ' choice
    
    if [ "$choice" == "0" ]; then
        exit 0
    elif [ "$choice" == "+" ]; then
        add_new_connection
    elif [ "$choice" == "-" ]; then
        delete_connection
    elif [ -n "${SERVERS[${SERVER_KEYS[$choice]}]}" ]; then
        echo "CONNECTING TO ${SERVER_KEYS[$choice]}..."
        ssh "${SERVERS[${SERVER_KEYS[$choice]}]}"
    else
        echo -e "\e[1;31;47mINVALID CHOICE_________________\e[0m"
    fi
done
