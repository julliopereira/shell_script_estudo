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
        echo -e "$command"; sleep 1
    done
}
#
(   sleep 1
    echo -e "$LOGIN"
    echo -e "$SENHA"; sleep 1
    func_commandos
) | telnet 10.0.3.2 > show.txt
cat show.txt

