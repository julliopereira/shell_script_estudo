#!/bin/bash
#
# AUTHOR            : JULIO CESAR PEREIRA           
# OBJETIVO          : PING VISUAL
# 
# v1.0 2022-09-21     Julio C. Pereira
#   -  
#
#
#
COUNT=1
LOOP=1
SUCCESS=0
UNSUCCESS=0
if [ -z $1 ]; then
    break
fi
IP=$1
#
mtu() {
    MTU=8
    while [ $MTU -ne 0 ]; do
        #IP=$1
        ping -c 2 -i 0.2 -W 0.3 -M do -s $MTU $IP &> /dev/null
        if [ $? -eq 0 ]; then
            #echo -e "$IP MTU\t= $MTU"
            let MTU+=20
        else
            let MTU-=20
            while [ $MTU -ne 0 ]; do
                ping -c 2 -i 0.2 -W 0.3 -M do -s $MTU $IP &> /dev/null
                if [ $? -eq 0 ]; then
                    #echo -e "$IP MTU\t= $MTU"
                    let MTU+=1
                else
                    let MTU-=1
                    echo -e "MTU\t: $MTU bytes"
                    MTU=0  
                fi
            done
        fi
    done
}
#
tempos() {
    TEMPOMIN=$(ping 10.0.2.2 -c 2 -i 0.2 | grep rtt | cut -d "=" -f 2 | awk -F "/" '{print $1} | echo "" | bc ')
    TEMPOMED=$(ping 10.0.2.2 -c 2 -i 0.2 | grep rtt | cut -d "=" -f 2 | awk -F "/" '{print $2}')
    TEMPOMAX=$(ping 10.0.2.2 -c 2 -i 0.2 | grep rtt | cut -d "=" -f 2 | awk -F "/" '{print $3}')
}
#
while [ ! -z $2 ] ; do
    #echo "valor de 2 : $2"
    
    case "$2" in
        -c ) 
            shift
            delim="$2"
            if [ ! -z $delim ]; then
                C=$2
            else
                echo "Não digitou a quantidade de pacotes."
            fi
            ;;
        -f )
            shift
            delim="$2"
            if [ ! -z $delim ]; then
                F=$2
            else
                echo "Não a frequência de envio!" ; echo
            fi
            ;;        
        *) 
            echo -e "Opção incorreta !" ;
            echo 
            ;;
    esac
    shift
done

if [ ! -z $C ]; then
    echo -n
else
    C=10
fi

if [ ! -z $F ]; then
    echo  
else
    F=1
fi
echo -e "----------------------------------------[$(date +%H:%M:%S.%3N)]----------------------------------------------"
#A=$(date +%H%M%S%3N)
while [ $COUNT -le $C ]; do
    #ping $IP -c 1 -W $F > /dev/null
    ping $IP -c 1 -W $F > /tmp/pingui
    if [ $? -eq 0 ]; then
        if [ $LOOP -lt 100 ]; then
            echo -ne "!"
            let LOOP++
            let SUCCESS++

        else
            LOOP=1
            echo -e "!"
            let SUCCESS++
        fi
    else
        if [ $LOOP -lt 99 ]; then
            echo -ne "."
            let LOOP++
            let UNSUCCESS++
        else
            LOOP=1
            echo -e "."
            let UNSUCCESS++
        fi
    fi 
    let COUNT++
done
echo -e "\r----------------------------------------[$(date +%H:%M:%S.%3N)]----------------------------------------------"
#Z=$(date +%H%M%S%3N)
echo -e "RETORNO\t: $SUCCESS"
echo -e "PERDAS\t: $UNSUCCESS"
tempos
echo -e "TEMPO MIN\t: $TEMPOMIN"
echo -e "TEMPO MED\t: $TEMPOMED"
echo -e "TEMPO MAX\t: $TEMPOMAX"
#echo -e "TEMPO\t: $(echo "$Z-$A" | bc) ms"
mtu
