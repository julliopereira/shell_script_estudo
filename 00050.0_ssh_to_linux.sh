#!/bin/bash
#
# NECESSARIO INSTALAR SSHPASS
# apt install sshpass
#
# ----------------------------------------------------------------------------
read -p "login: " LOGIN			           # PEDIR LOGIN PARA O USUARIO
read -s -p "senha: " SSHPASS               # PEDIR A SENHA PARA O USUARIO
export SSHPASS				               # EXPORTAR A SENHA 
#
#
#
#
# LIMPAR A TELA:
clear
#
#
#
#
# COMANDOS A SEREM EXECUTADOS NA MAQUINA REMOTA:
#COMM="date +%Y%m%d"
COMM=$(cat command)             # COMANDOS NO ARQUIVO command
#
#
#
#
func_ssh () { 
    # INICIA SESSAO NAO SOLICITANDO OK PARA INCLUSAO EM knowhosts
    # E EXECUTA COMANDOS DA VARIAVEL $COMM 
    # SALVANDO RESULTADO DOS COMANDOS EM /tmp/
    rm -fr /tmp/$IP'command.txt'
    echo -e "# =======================================[$IP]======================================= #" > /tmp/$IP'command.txt'
	sshpass -e ssh $LOGIN@$IP -o StrictHostKeyChecking=no "$COMM" >> /tmp/$IP'command.txt'
} 
#
func_filtra () {
    # FILTRA APENAS AS LINHAS DE INTERFACE E IP 
    #cat /tmp/$IP'command.txt' | egrep "^[0-9]:|inet" | grep -v "inet6" > /tmp/$IP'filtra_interf_ip'
    # FILTRA O NOME DA MAQUINA:
    #cat /tmp/$IP'command.txt' | egrep "hostname" > /tmp/$IP'hostname'
    echo
}
#
func_data () {
    DATA=$(date +%Y%m%d_%H:%M)
}
#
#
#
#
#
for IP in $(cat IPS); do                    # APLICA EM CADA IP 
    ping -c 2 -i 0.2 -W 0.5 $IP > /dev/null
    if [ $? -eq 0 ]; then 
	    func_ssh
        #func_filtra
    else
        func_data 
        echo -e "$IP\tNo Ping!" >> down$DATA.log 
    fi
done 
#
#
unset SSHPASS                               # APOS RODAR TODO SCRIPT REALIZANDO AS COLETAS O REMOVE DE env
#
#
exit 0 
