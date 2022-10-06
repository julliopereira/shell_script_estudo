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
IP=$2


menu() {
    case $1 in
        -c) shift
            if [ ! -z $1  ]; then
                C=$1
            else
                echo "Não digitou a quantidade de pacotes."
            fi
            ;; 
    esac
}

menu 
echo quantidade $C 
#while [ $COUNT -le $C ]; do


#done