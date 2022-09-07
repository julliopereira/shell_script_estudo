#!/bin/bash
#
VERD="\033[42;37;1m"
VERM="\033[47;37;5m"
STRO="\033[47;30;5m"
CLEAR="\033[m"
#
func_conn(){
    # conexão / tempo de resposta [méd] / qtd de pacotes recebidos
    clear
    MEDIA=$(cat /tmp/$IP'ping'.txt | egrep "rtt" | cut -d '=' -f 2 | cut -d '/' -f 2)
    RECEB=$(cat /tmp/$IP'ping'.txt | grep "received" | cut -d ',' -f 2 | awk -F ' ' '{print $1}')
    echo -e "IP $STRO $IP $CLEAR:"
    echo -e "\t- Ping \t\t : OK "
    echo -e "\t- Média\t\t : $MEDIA ms \t[ 10 x ]"
    if [ $RECEB -eq 10 ]; then
        echo -e "\t- Recebidos\t : $RECEB \t\t[ ?/10 ]"
    else
        echo -e "\t- Recebidos\t : $VERM $RECEB $CLEAR\t\t[ ?/10 ]"
    fi
    echo -e "============================================================================="
}
#
func_variacao() {
    # variacao entre o menor e maior tempo de resposta
    echo -e ""
    echo -e "============================================================================="
}
#
func_err() {
    # testar varios tamanhos de pacotes
    # mostrar quantos pacotes recebidos ?/50
    echo -e ""
    echo -e "============================================================================="
}
#
func_mtu() {
    # testar maximo MTU possível
    echo -e ""
    echo -e "============================================================================="
}
#

#
if [ -z $1 ]; then 
    echo -e "FAVOR DIGITAR UM DESTINO PARA REALIZAR TESTES ..."
    #echo -e "PLEASE INPUT A TARGET TO REALIZE THE TEST"
    #echo -e "POR FAVOR ANADIR UN DESTINO PARA SEGUIR LA EVALUACION"
else
    for IP in $(echo $1); do
        ping $IP -c 10 -i 0.2 -W 1 > /tmp/$IP'ping'.txt
        if [ $? -eq 0 ]; then
            case $2 in   
                1) func_conn ;;
                2) func_conn; 
            esac 
        fi
    done
fi
#
#rm -f /tmp/$IP'ping'.txt



