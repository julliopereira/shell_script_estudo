#!/bin/bash

#!/bin/bash
#
echo ":: Qual o a opcao desejada?: "
tecla=""

# Poe o terminal em modo especial de interpretacao de caracteres
stty -echo -icanon min 0

while true
do	
	clear
	[ "$tecla" = "s" ] && break
	[ "$tecla" = "1" ] && break
	[ "$tecla" = "2" ] && break
	[ "$tecla" = "3" ] && break
	[ "$tecla" = "4" ] && break	
	[ "$tecla" = "5" ] && break
	echo -e "[01] opcao 1"
	echo -e "[02] opcao 2"
	echo -e "[03] opcao 3"
	echo -e "[04] opcao 4"
	echo -e "[05] opcao 5\n"
	echo -e "[ s ]  sair \n"
	echo -n "opc: "
	sleep 1
	read tecla 
	T1=$tecla
done

# Restaura o modo padrao
stty sane

echo -e "você digitou \"$T1\""
echo "Tchau loop."

exit 0
