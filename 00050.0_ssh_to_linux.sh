#!/bin/bash
#
# NECESSARIO INSTALAR SSHPASS
# apt install sshpass
#
# ----------------------------------------------------------------------------
read -p "digitar login: " LOGIN			   # PEDIR LOGIN PARA O USUARIO
read -s -p "digitar a senha: " SSHPASS     # PEDIR A SENHA PARA O USUARIO
export SSHPASS				               # EXPORTAR A SENHA 
# LIMPAR A TELA:
clear
# COMANDOS A SEREM EXECUTADOS NA MAQUINA REMOTA:
COMM="ip a; \
	  hostnamectl; "
#
func_ssh () { 
    # INICIA SESSAO NAO SOLICITANDO OK PARA INCLUSAO EM knowhosts
    # E EXECUTA COMANDOS DA VARIAVEL $COMM 
    # SALVANDO RESULTADO DOS COMANDOS EM /tmp/
	sshpass -e ssh $LOGIN@$IP -o StrictHostKeyChecking=no "$COMM" > /tmp/$IP'comm'
} 
#
func_filtra () {
    # FILTRA APENAS AS LINHAS DE INTERFACE E IP 
    cat /tmp/$IP'comm' | egrep "^[0-9]:|inet" | grep -v "inet6" > /tmp/$IP'filtra_interf_ip'
    # FILTRA O NOME DA MAQUINA:
    cat /tmp/$IP'comm' | egrep "hostname" > /tmp/$IP'hostname'
}
#
func_data () {
    DATA=$(date +%Y%m%d_%H:%M)
}
#
for IP in $(cat IPS); do                    # APLICA EM CADA IP 
    ping -c 2 -i 0.2 -W 1 $IP > /dev/null
    if [ $? -eq 0 ]; then 
	    func_ssh
        func_filtra
    else
        func_data 
        echo -e "$IP\tNo Ping!" > down$DATA.log 
    fi
done 
#
unset SSHPASS                               # APOS RODAR TODO SCRIPT REALIZANDO AS COLETAS O REMOVE DE env
 