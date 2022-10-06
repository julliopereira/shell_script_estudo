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
        if [ ! -z $delim ]; then
            F=$2
        else
            echo "Não digitou a quantidade de pacotes!" ; echo
        fi
        ;;        
      *) 
        echo -e "Opção incorreta !" ;
        echo 
        ;;
esac

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

ping $1 -c $C -i $F

