#!/bin/bash
#
func_conn(){
    # conexão / tempo de resposta [méd] / 
    echo
}
#
func_err() {
    # testar varios tamanhos de pacotes
    # mostrar quantos pacotes recebidos ?/50
    echo
}
#
func_mtu() {
    # testar maximo MTU possível
    echo
}
#

for IP in $(cat $1); do
    ping $IP -c 2 -i 0.2 -W 1 > /dev/null
    if []; then
    
    fi
done


