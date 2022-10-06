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
        IP=$1
        ping -c 1 -i 0.2 -M do -s $MTU $IP &> /dev/null
        if [ $? -eq 0 ]; then
            #echo -e "$IP MTU\t= $MTU"
            let MTU+=20
        else
            let MTU-=20
            while [ $MTU -ne 0 ]; do
                ping -c 1 -i 0.2 -M do -s $MTU $IP &> /dev/null
                if [ $? -eq 0 ]; then
                    #echo -e "$IP MTU\t= $MTU"
                    let MTU+=1
                else
                    let MTU-=1
                    echo -e "$IP MTU\t= $MTU ( Max) "
                    #MTU=0
                fi
            done
        fi
    done
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
echo -e "----------------------------------------[$(date +%H:%M:%S.%3N)]---------------------------------------------"
A=$(date +%H%M%S%3N)
while [ $COUNT -le $C ]; do
    ping $IP -c 1 -W $F > /dev/null
    if [ $? -eq 0 ]; then
        if [ $LOOP -lt 99 ]; then
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
echo -e "\n----------------------------------------[$(date +%H:%M:%S.%3N)]---------------------------------------------"
Z=$(date +%H%M%S%3N)
mtu
echo -e "RETORNO\t: $SUCCESS"
echo -e "PERDAS\t: $UNSUCCESS"
echo -e "TEMPO\t: $(echo "$Z-$A" | bc) ms"
echo -e "MTU\t: $MTU"
