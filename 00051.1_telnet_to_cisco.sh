#!/bin/bash
#
# INPUTS:
read -p "login: " LOGIN 
read -s -p "password: " SENHA
#
#
#
# FUNCOES:
func_commandos() {
    for comm in $(cat telnet_cmds.txt | tr ' ' '_'); do
        command=$(echo -e "$comm" | tr '_' ' ')
        echo -e "$command" ; sleep 3
    done
}
#
(   sleep 1
    echo -e "$LOGIN"; sleep 1
    echo -e "$SENHA"; sleep 1
    func_commandos
) | telnet 10.0.2.195 > show.txt

