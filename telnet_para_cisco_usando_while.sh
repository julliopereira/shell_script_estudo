#!/usr/bin/env bash

arquivo_input='arquivo_telnet.txt'

(
  echo "cisco";sleep 1
  echo "cisco";sleep 1
  while IFS= read -r comando; do # IFS= assegura que a linha vai ser lida inteira
	echo "$comando"
	sleep 1
  done < "$arquivo_input"	 # variavel onde está o arquivo	
  echo "exit"  
) | telnet $1 > telnet_output.txt

cat telnet_output.txt

exit 0
