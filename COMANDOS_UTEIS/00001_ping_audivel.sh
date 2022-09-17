#!/bin/bash
#
# AUTHOR:                   JULIO C. PEREIRA
# INICIO:                   2022-09-17
# CONTATO:                  julliopereira@gmail.com
# OBJETIVO:                 MONITORAR CONEXOES POR ICMP
#                           COM NAO SUCESSO AUDIVEL GRAVANDO
#                           RESULTADO EM ARQUIVOS down E up
#################################################################
#
# CONTROLE DE DIRETORIO: ========================================
if [ ! -e log/ ]: then
    mkdir log
fi
#
# TRATAMENTO DE INPUT: ==========================================
IP=$1
NR=$2
MTU=$3
#
# DEFINICOES DE VARIAVEIS:
FUSO=0
#
# FUNCOES: ======================================================
func_data() {
    DATA=$(date -d "$FUSO hour" +%Y%m%d_%H:%M:%S)
}
# MAIN: =========================================================
for ((i=0;i<=$2;i++)); do
    ping $IP -c 1 -i 0.5 -W 0.6 &> /dev/null
    if [ $? -eq 0 ]; then
        func_data
        echo -e "$i:\t[$DATA] \t: UP" > log/log$DATA.log
    else
        func_data
        echo -e "$i:\t[$DATA] \t: DW \a" > log/log$DATA.log
    fi
done



# COMMANDO:
# for ((i=0;i<1000;i++)); do ping 8.8.8.8 -c 1 -i 0.015 -W 0.005 &> /dev/null || echo -e "\a $i $?" ; done