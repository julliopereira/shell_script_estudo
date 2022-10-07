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
MIN=1000
MED=0
MAX=0
#
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
                    echo -e "MTU\t\t: $MTU bytes"
                    MTU=0  
                fi
            done
        fi
    done
}
#
tempo() {
    #TEMPOMIN=$(test=$(cat /tmp/pingui | grep rtt | cut -d "=" -f 2 | awk -F "/" '{print $1}') ; echo "$test-0" | bc )
    #TEMPOMED=$(cat /tmp/pingui | grep rtt | cut -d "=" -f 2 | awk -F "/" '{print $2}')
    TEMPOMAX=$(cat /tmp/pingui | grep rtt | cut -d "=" -f 2 | awk -F "/" '{print $3}')
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
            tempo
            if [ $(echo "$TEMPOMAX >= $MAX" | bc) -eq 1 ]; then
                MAX="$TEMPOMAX"
            fi
            MED=$(echo "$TEMPOMAX+$MED" | bc)
            if [ $(echo "$TEMPOMAX <= $MIN" | bc) -eq 1 ]; then
                MIN="$TEMPOMAX"
            fi
        else
            LOOP=1
            echo -e "!"
            let SUCCESS++
            tempo
            if [ $(echo "$TEMPOMAX >= $MAX" | bc) -eq 1 ]; then
                MAX="$TEMPOMAX"
            fi
            MED=$(echo "$TEMPOMAX+$MED" | bc)
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
echo -e "\n----------------------------------------[$(date +%H:%M:%S.%3N)]----------------------------------------------"
#Z=$(date +%H%M%S%3N)
echo -e "RETORNO\t\t: $SUCCESS"
echo -e "PERDAS\t\t: $UNSUCCESS"

#echo -e "TEMPO MIN\t: $MIN ms"
if [ $SUCCESS -ne 0 ]; then
    echo -e "TEMPO MAX\t: $MAX ms"
    MED=$(echo "$MED/$COUNT" | bc)
    echo -e "TEMPO MED\t: $MED ms"
    mtu
fi
#tempos
#echo -e "TEMPO MIN\t: $TEMPOMIN"
#echo -e "TEMPO MED\t: $TEMPOMED"
#echo -e "TEMPO MAX\t: $TEMPOMAX"
#echo -e "TEMPO\t: $(echo "$Z-$A" | bc) ms"
#mtu
