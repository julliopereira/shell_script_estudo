#!/bin/bash

# DEFINIR 3 VARIAVEIS A E B E C 

A=10.1234
B=11.1234
C=$A

# VERIFICAR IGUALDADE ENTRE AS VARIAVEIS

RES=$(echo "$A == $B" | bc)            # valor = 1 (TRUE) / valor = 0 (FALSE)
echo "RESULTADO: $RES"

RES=$(echo "$A < $B" | bc)
echo "RESULTADO: $RES"

RES=$(echo "$A != $B" | bc)
echo "RESULTADO: $RES"

RES=$(echo "$A != $C" | bc)
echo "RESULTADO: $RES"



[ $(echo "10.1234+1.345") == $B ] && echo "ÏGUAL1" || echo "DIFERENTE1"       # vaz um calculo e verifica se igual a B

[ $A == $C ] && echo "ÏGUAL2" || echo "DIFERENTE2"                   # calcula se duas variveis tem mesmo valor

[ $(echo "$A") == $B ] && echo "ÏGUAL1" || echo "DIFERENTE1"
