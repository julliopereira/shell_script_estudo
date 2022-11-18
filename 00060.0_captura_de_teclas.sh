#!/bin/bash

#!/bin/bash
#
echo ":: Pressione a tecla 's' para sair ::"
tecla=""

# Poe o terminal em modo especial de interpretacao de caracteres
stty -echo -icanon min 0

while true
do
	[ "$tecla" = "s" ] && break
	echo "Hello World!"
	sleep 1
	read tecla
done

# Restaura o modo padrao
stty sane

echo "Tchau loop."

exit 0
