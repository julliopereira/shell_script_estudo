#!/bin/bash
#
VERD="\033[42;37;1m"
VERM="\033[47;37;1m"
STRO="\033[42;37;5m"
CLEAR="\033[m"
#
func_conn(){
    # conexão / tempo de resposta [méd] 
    MEDIA=$(cat /tmp/10.0.2.105ping.txt | egrep "rtt" | cut -d '=' -f 2 | cut -d '/' -f 2)
    echo -e "IP $STRO $IP $CLEAR:"
    echo -e "\t- Ping \t\t : OK "
    echo -e "\t- Média\t\t : $MEDIA ms"
}
#
func_err() {
    # testar varios tamanhos de pacotes
    # mostrar quantos pacotes recebidos ?/50
    echo -e ""
}
#
func_variacao() {
    # variacao entre o menor e maior tempo de resposta
    echo -e ""
}
#
func_mtu() {
    # testar maximo MTU possível
    echo -e ""
}
#

#
for IP in $(echo $1); do
    ping $IP -c 10 -i 0.2 -W 1 > /tmp/$IP'ping'.txt
    if [ $? -eq 0 ]; then
        func_conn
    fi
done
#
rm -f /tmp/$IP'ping'.txt



