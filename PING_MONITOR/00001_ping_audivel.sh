#!/bin/bash
#
# AUTHOR:                   JULIO C. PEREIRA
# INICIO:                   2022-09-17
# CONTATO:                  julliopereira@gmail.com
# OBJETIVO:                 MONITORAR CONEXOES POR ICMP
#                           COM NAO SUCESSO AUDIVEL GRAVANDO
#                           RESULTADO EM ARQUIVOS down E up
# SIST. OPERACIONAL:        LINUX
#
# v0.0                      2022-09-07                      
#                               INICIO
#
#
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
FREQ=0.2                # FREQUENCIA ENTRE CADA DISPARO ICMP
AGUAR=0.5              # TEMPO DE ESPERA DE RESPOSTA DE ICMP
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
    cat /tmp/evi | grep rtt | cut -d "=" -f 2| awk -F "/" '{print $2}' | grep "." > /tmp/med
    if [ -z /tmp/med ]; then
        MED=$(cat /tmp/med)
    else
        MED=$(cat /tmp/med | cut -d "." -f 1)
    fi
}
#
func_latencia() {
    if [ $MED -le $TM ]; then
        TEMPO="OK"
    else
        TEMPO=">>"
    fi
}
#
# MAIN: =========================================================
while true; do               # COMENTAR A LINHA for LOGO ABAIXO PARA LOOP INFINITO
    cat NES | grep -v "#" > /tmp/nes
    for linha in $(cat /tmp/nes); do
        func_filtra
        ping $IP -c 2 -i $FREQ -W $AGUAR &> /tmp/evi
        if [ $? -eq 0 ]; then
            func_data
            func_calculo_tempo
            func_latencia
            echo -e "[$DATAS]:$IP:STATUS=UP:MTU=$MTU:LATENCIA=$MED"ms":LATENCIA_OK=$TEMPO:NOME=$NOME" >> log/log$DATA.log
        else
            func_data
            echo -e "[$DATAS]:$IP:STATUS=DW:MTU=$MTU:NOME=$NOME:>>CRITICO<< \a" >> log/log$DATA.log
        fi
    done
done



# COMMANDO:
# for ((i=0;i<1000;i++)); do ping 8.8.8.8 -c 1 -i 0.015 -W 0.005 &> /dev/null || echo -e "\a $i $?" ; done