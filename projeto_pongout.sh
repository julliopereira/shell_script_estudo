#!/bin/bash
#
VERD="\033[42;37;1m"
VERM="\033[47;37;5m"
STRO="\033[47;30;5m"
CLEAR="\033[m"
#
func_help() {
    clear
    echo -e "
    Use:    $(basename $0) [ip|name]... [opc]...
            connection test with icmp packet


            opc:
                - 1 ,          connection status test
                - 2 ,          variation between min and max time
                - 3 ,          connection quality (packet losses)
                - 4 ,          maximum MTU size
                - h , --help   help


            example:
                $(basename $0) 10.0.2.105 3
    "
}
#
func_data() {
    # data e hora atual
    DATA=$(date +%Y%m%d_%H:%M:%S)
}
#
func_conn(){
    # conexão / tempo de resposta [méd] / qtd de pacotes recebidos
    clear
    func_data
    MEDIA=$(cat /tmp/$IP'ping'.txt | egrep "rtt" | cut -d '=' -f 2 | cut -d '/' -f 2)
    RECEB=$(cat /tmp/$IP'ping'.txt | grep "received" | cut -d ',' -f 2 | awk -F ' ' '{print $1}')
    echo -e "IP $STRO $IP $CLEAR [data/hora: $DATA]:"
    echo -e "\t- Ping \t\t : OK "
    echo -e "\t- Média\t\t : $MEDIA ms "
    if [ $RECEB -eq 10 ]; then
        echo -e "\t- Recebidos\t : $RECEB "
    else
        echo -e "\t- Recebidos\t : $VERM $RECEB $CLEAR"
    fi
    echo -e "============================================================================="
}
#
func_variacao() {
    # variacao entre o menor e maior tempo de resposta
    MIN=$(cat /tmp/$IP'ping'.txt | egrep "rtt" | cut -d '=' -f 2 | cut -d '/' -f 1)
    MAX=$(cat /tmp/$IP'ping'.txt | egrep "rtt" | cut -d '=' -f 2 | cut -d '/' -f 3)
    VARIACAO=$(bc<<<$MAX-$MIN)
    echo -e "\t- Variação\t : $VARIACAO ms\t[ Max-Min ]" 
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

if [[ $1 == "-h"  ||  $1 == "--help" ]]; then
    func_help
else
    if [ -z $1 ]; then 
        func_help
    else
        for IP in $(echo $1); do
            ping $IP -c 10 -i 0.2 -W 1 > /tmp/$IP'ping'.txt
            if [ $? -eq 0 ]; then
                if [ -z $2 ]; then 
                    func_conn
                else
                    case $2 in   
                        1) func_conn ;;
                        2) func_conn; func_variacao ;;
                        3) func_conn; func_variacao; func_err ;;
                        4) func_conn; func_variacao; func_err; func_mtu ;;
                        -h|--help) func_help ;;
                        *) echo -e "INFORMAÇÃO INCORRETA, TENTE NOVAMENTE..." ;;
                    esac
                fi
            else
                clear
                func_data
                echo -e "[$DATA]\t $STRO IP [ $IP ] NÃO ACESSÍVEL .... $CLEAR"
            fi
        done
    fi
fi
#
#rm -f /tmp/$IP'ping'.txt



