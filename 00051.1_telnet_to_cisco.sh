#!/bin/bash
#
#
#
#
# INPUTS:
read -p "login: " LOGIN 
read -s -p "password: " SENHA
#
#
#
# FUNCOES:
func_commandos() {
    for comm in $(cat telnet_cmds.txt); do
        echo -e $comm ; sleep 2
    done
}
#
(   sleep 1
    echo -e "$LOGIN"; sleep 1
    echo -e "$SENHA"; sleep 2
    echo -e "\r\r" ; sleep 3
    #echo -e "ip a" ; sleep 1
    func_commandos
 ) | telnet 10.0.2.195 > show.txt

