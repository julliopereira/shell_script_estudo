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
IP=$1

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
    echo
else
    C=10
fi

if [ ! -z $F ]; then
    echo
else
    F=1
fi

while [ $COUNT -le $C ]; do
    ping $IP -c 1 -W $F
    if [ $? -eq 0 ]; then
        
    fi  

done
