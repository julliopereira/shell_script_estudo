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
# CONTROLE DE DIRETORIO E ARQUIVOS: =============================
if [ ! -e log/ ]; then
    mkdir log
fi
#
# TRATAMENTO DE INPUT: ==========================================
#IP=$1
#NR=$2
#MTU=$3
#
# DEFINICOES DE VARIAVEIS:
FUSO=0
#
# FUNCOES: ======================================================
func_data() {
    DATA=$(date -d "$FUSO hour" +%Y%m%d)             # DATA DIA MES ANO
    DATAS=$(date -d "$FUSO hour" +%Y%m%d_%H:%M:%S)   # DATA COM SEGUNDOS
}
#
func_filtra() {
    IP=$(echo -e "$linha"| cut -d ":" -f 1)           # IP
    MTU=$(echo -e "$linha" | cut -d ":" -f 2)         # MTU
    TM=$(echo -e "$linha" | cut -d ":" -f 3)          # TEMPO MEDIO
    TR=$(echo -e "$linha" | cut -d ":" -f 4)          # TEMPO A REDUZIR
    NOME=$(echo -e "$linha" | cut -d ":" -f 5)        # NOMES E INFORMACOES DIVERSAS
}
#
func_calculo_tempo() {
    
}
#
# MAIN: =========================================================
while true; do               # COMENTAR A LINHA for LOGO ABAIXO PARA LOOP INFINITO
    echo "teste1"
    cat NES | grep -v "#" > /tmp/nes
    for linha in $(cat /tmp/nes); do
        func_filtra
        ping $IP -c 2 -i 0.2 -W 0.5 &> /tmp/
        if [ $? -eq 0 ]; then
            func_data
            echo -e "[$DATAS]:$IP:UP:$MTU" >> log/log$DATA.log
        else
            func_data
            echo -e "[$DATAS]:$IP:DW:$MTU \a" >> log/log$DATA.log
        fi
    done
done



# COMMANDO:
# for ((i=0;i<1000;i++)); do ping 8.8.8.8 -c 1 -i 0.015 -W 0.005 &> /dev/null || echo -e "\a $i $?" ; done