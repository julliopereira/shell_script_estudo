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
#
#
# DEFINICOES DE VARIAVEIS:
FUSO=0                 # ALTERAR FUSO EX: -3 ou 3 ou -1 etc...
FREQ=0.2               # FREQUENCIA ENTRE CADA DISPARO ICMP  (EM SEGUNDOS)
AGUAR=0.5              # TEMPO DE ESPERA DE RESPOSTA DE ICMP (EM SEGUNDOS)
#
# FUNCOES: ======================================================
func_data() {
    # define data
    DATA=$(date -d "$FUSO hour" +%Y%m%d)             # DATA DIA MES ANO
    DATAS=$(date -d "$FUSO hour" +%Y%m%d_%H:%M:%S)   # DATA COM SEGUNDOS
}
#
func_filtra() {
    # filtra informações do arquivo NES neste mesmo diretório
    IP=$(echo -e "$linha"| cut -d ":" -f 1)           # IP
    MTU=$(echo -e "$linha" | cut -d ":" -f 2)         # MTU
    TM=$(echo -e "$linha" | cut -d ":" -f 3)          # TEMPO MEDIO
    TR=$(echo -e "$linha" | cut -d ":" -f 4)          # TEMPO A REDUZIR
    NOME=$(echo -e "$linha" | cut -d ":" -f 5)        # NOMES E INFORMACOES DIVERSAS
}
#
func_calculo_tempo() {
    # transforma a latência em numero inteiro ( em milissegundos )
    cat /tmp/evi | grep rtt | cut -d "=" -f 2| awk -F "/" '{print $2}' | grep "." > /tmp/med
    if [ -z /tmp/med ]; then
        MED=$(cat /tmp/med)
    else
        MED=$(cat /tmp/med | cut -d "." -f 1)
    fi
}
#
func_latencia() {
    # compara a latência do teste com a latência média de input
    if [ $MED -le $TM ]; then
        TEMPO="OK"
    else
        TEMPO=">>"
    fi
}
#
func_logup() {
    echo -e "[$DATAS]:$IP:STATUS=UP:MTU=$MTU:LATENCIA=$MED"ms":LATENCIA_OK=$TEMPO:NOME=$NOME" >> log/log$DATA.log
    ARQ=$(cat log/down.log | grep "$IP")
    if [ -n "$ARQ" ];then
        sed -i "/$IP/d" log/down.log
    fi
}
#
func_logdown() {
    echo -e "[$DATAS]:$IP:STATUS=DW:MTU=$MTU:NOME=$NOME:\033[31;5m>>CRITICO<<\033[m " >> log/log$DATA.log 
    ARQ=$(cat log/down.log | grep "$IP")
    if [ -z "$ARQ" ];then
        echo -e "[$DATAS]:$IP:STATUS=DW:MTU=$MTU:NOME=$NOME:\033[31;5m>>CRITICO<<\033[m " >> log/down.log
    fi
}
#
func_dwtest() {
    func_data
    ping $IP -c 10 -i 0.2 -W 0.3 -M do -s $MTU &> /tmp/dwtst
}
#
# MAIN: =========================================================
while true; do               # LOOP INFINITO
    cat NES | grep -v "#" > /tmp/nes
    for linha in $(cat /tmp/nes); do
        func_filtra
        ping $IP -c 1 -i $FREQ -W $AGUAR -M do -s $MTU &> /tmp/evi
        if [ $? -eq 0 ]; then
            func_data
            func_calculo_tempo
            func_latencia
            func_logup
            #echo -e "[$DATAS]:$IP:STATUS=UP:MTU=$MTU:LATENCIA=$MED"ms":LATENCIA_OK=$TEMPO:NOME=$NOME" >> log/log$DATA.log
            #ARQ=$(cat log/down.log | grep "$IP")
            #if [ -n "$ARQ" ];then
            #    sed -i "/$IP/d" log/down.log
            #fi
        else

            #ping $IP -c 10 -i 0.2 -W 0.3 -M do -s $MTU &> /tmp/dwtst
            #if [ $? -eq 1 ]; then
            #    func_data
            #    func_logdown
                #echo -e "[$DATAS]:$IP:STATUS=DW:MTU=$MTU:NOME=$NOME:>>CRITICO<< " >> log/log$DATA.log 
                #ARQ=$(cat log/down.log | grep "$IP")
                #if [ -z "$ARQ" ];then
                #    echo -e "[$DATAS]:$IP:STATUS=DW:MTU=$MTU:NOME=$NOME:>>CRITICO<< " >> log/down.log
                #fi
            #fi
        fi
    done
done