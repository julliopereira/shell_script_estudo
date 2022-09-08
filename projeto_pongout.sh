#!/bin/bash
#
#
#
# QUANTIDADE DE PACOTES A SEREM TESTADOS INICIALMENTE:
PKTS=15
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
                - 5 ,          trace to destination
                - h , --help   help


            example:
                $(basename $0) 10.0.2.105 3
    "
}
#
func_servico() {
    # coleta informaçoes do servico
    echo -e -n "CIRCUITO\t\t: "; read SERV
    echo -e -n "BANDWIDTH[Mbps]\t\t: "; read BW
    echo -e "============================================================================="
}
#
func_data() {
    # data e hora atual
    DATA=$(date +%Y%m%d_%H:%M:%S)
}
#
func_pkts() {
    # quantidade de pacotes para teste de erros
    echo -e -n "\t- TESTE de PERDAS de PACOTES [ Qde ]: "; read PKTS
}
#
func_conn() {
    # [1] conexão / tempo de resposta [méd] / qtd de pacotes recebidos
    func_data
    MEDIA=$(cat /tmp/$IP'ping'.txt | egrep "rtt" | cut -d '=' -f 2 | cut -d '/' -f 2)
    RECEB=$(cat /tmp/$IP'ping'.txt | grep "received" | cut -d ',' -f 2 | awk -F ' ' '{print $1}')
    echo -e "\t- Ping \t\t : OK "
    echo -e "\t- Média\t\t : $MEDIA ms \t[ $PKTS pkts ]"
    if [ $RECEB -eq $PKTS ]; then
        echo -e "\t- Recebidos\t : $RECEB \t\t[ $PKTS pkts ]"
    else
        echo -e "\t- Recebidos\t : $RECEB \t\t[ $PKTS pkts ]\t<<"
    fi
    echo -e "============================================================================="
}
#
func_variacao() {
    # [2] variacao entre o menor e maior tempo de resposta
    MIN=$(cat /tmp/$IP'ping'.txt | egrep "rtt" | cut -d '=' -f 2 | cut -d '/' -f 1)
    MAX=$(cat /tmp/$IP'ping'.txt | egrep "rtt" | cut -d '=' -f 2 | cut -d '/' -f 3)
    VARIACAO=$(bc<<<$MAX-$MIN)
    echo -e "\t- Variação\t : $VARIACAO ms\t[ Max-Min ]" 
    echo -e "============================================================================="
}
#
func_err() {
    # [3] testar varios tamanhos de pacotes
    # mostrar quantos pacotes recebidos 
    echo -e ""
    for SIZE in 64 400 800 1100 1400; do
        ping $IP -c $PKTS -i 0.2 -W 1 -p AAAA -s $SIZE > /tmp/$IP'ping'.txt
        RECEB=$(cat /tmp/$IP'ping'.txt | grep "received" | cut -d ',' -f 2 | awk -F ' ' '{print $1}')
        if [ $RECEB -eq $PKTS ]; then
            echo -e "\t- Recebidos1\t : $RECEB \t\t[ $PKTS pkts | MTU: $SIZE ]"
        else
            echo -e "\t- Recebidos1\t : $RECEB \t\t[ $PKTS pkts | MTU: $SIZE ]\t\t<<"
        fi
    done
    echo -e "\t-------------------------------------------------------"
    for SIZE in 64 400 800 1100 1400; do
        ping $IP -c $PKTS -i 0.2 -W 1 -p FFFF -s $SIZE > /tmp/$IP'ping'.txt
        RECEB=$(cat /tmp/$IP'ping'.txt | grep "received" | cut -d ',' -f 2 | awk -F ' ' '{print $1}')
        if [ $RECEB -eq $PKTS ]; then
            echo -e "\t- Recebidos2\t : $RECEB \t\t[ $PKTS pkts | MTU: $SIZE ]"
        else
            echo -e "\t- Recebidos2\t : $RECEB \t\t[ $PKTS pkts | MTU: $SIZE ]\t\t<<"
        fi
    done
    #echo -e "ERR\t:EM DESENVOLVIMENTO ..."
    echo -e "============================================================================="
}
#
func_mtu() {
    # [4] testar maximo MTU possível
    MTU=64
    while [ $MTU -le 9000 ] ; do
        ping $IP -c 2 -i 0.2 -W 1 -M do -s $MTU > /dev/null
        if [ $? -eq 0 ]; then
            echo -e "PRI $TM $MTU"
            TM=$MTU 
            let MTU+=500
        else
            while [ $TM -lt $MTU ]; do
                echo -e "SEG UM"
                ping $IP -c 2 -i 0.2 -W 1 -M do -s $MTU > /dev/null
                if [ $? -eq 0 ]; then
                    echo -e "SEG $TM $MTU"
                    TM=$MTU 
                    let MTU+=1
                else
                    echo -e "BREAK"
                    break

                fi
            done
        fi
    done
    echo -e "TEST" 
    # echo -e "MTU\t:EM DESENVOLVIMENTO ..."
    echo -e "============================================================================="
}
#
func_trace() {
    # [5] Traceroute até para o destino
    echo -e "TRACE\t:EM DESENVOLVIMENTO ..."
    echo -e "============================================================================="
}
#
clear 
echo -e "AGUARDE ..."
if [[ $1 == "-h"  ||  $1 == "--help" ]]; then
    func_help
else
    if [ -z $1 ]; then 
        func_help
    else
        for IP in $(echo $1); do
            ping $IP -c $PKTS -i 0.2 -W 1 > /tmp/$IP'ping'.txt
            if [ $? -eq 0 ]; then
                if [ -z $2 ]; then 
                    func_conn
                else
                    clear
                    func_data
                    echo -e "INICIO> $STRO $IP $CLEAR [data/hora: $DATA]:"
                    echo -e "============================================================================="
                    func_servico
                    case $2 in   
                        1) func_conn ;;
                        2) func_conn; func_variacao ;;
                        3) func_conn; func_variacao; func_pkts; func_err ;;
                        4) func_conn; func_variacao; func_pkts; func_err; func_mtu ;;
                        5) func_conn; func_variacao; func_pkts; func_err; func_mtu; func_trace ;;
                        -h|--help) func_help ;;
                        *) echo -e "INFORMAÇÃO INCORRETA, TENTE NOVAMENTE..." ;;
                    esac
                fi
                func_data
                echo -e "FIM   > $STRO $IP $CLEAR [data/hora: $DATA]:"
            else
                clear
                func_data
                echo -e "IP $STRO $IP $CLEAR [data/hora: $DATA]:"
                echo -e "\t- Ping \t\t : NÃO ACESSÍVEL \t<<"
            fi
        done
    fi
fi
#
# rm -f /tmp/$IP'ping'.txt
exit 0



