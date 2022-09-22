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
(
    echo -e "$LOGIN"; sleep 1
    echo -e "$SENHA"; sleep 3
    func_commandos
 ) | telnet 10.0.2.195 > show.txt

