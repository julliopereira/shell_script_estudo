#!/bin/bash
#
# AUTHOR            : JULIO C. PEREIRA       
# CONTATO           : JULLIOPEREIRA@GMAIL.COM    
# OBJETIVO          : TESTE COM ICMP
# 
# v0.1 2022-09-21   Julio C. Pereira
#   - Iniciado
#
# v1.0 2022-09-07   Julio C. Pereira   
#   - Adicionado funções
#
# V1.1 2022-10-13   Julio C. Pereira
#   - Adicionada ajuda
#
#
#-----------------------------[MENSAGEM]----------------------------
HELP="
Uso: $(basename $0) [TARGET] [OPCOES]

    -c [n]      Quantidade de pacotes a serem enviados/recebidos
    -t [n]      Tempo entre um envio em seg, ex: 1 | 0.1 | 0.3
    -m [s|n]    Verificar tamanho máximo de pacote (MTU)
    -s [n]      Tamanho de pacote a ser encaminhado/recebido
    -h,--help   Ajuda

exemplo:

     $(basename $0) 10.0.2.2 -c 20
     $(basename $0) 10.0.2.2 -c 20 -s 128
     $(basename $0) 10.0.2.2 -c 20 -s 800 -t 0.3
     $(basename $0) 10.0.2.2 -c 20 -s 800 -t 0.3 -m s
"

# ----------------------------[VARIAVEIS]----------------------------
COUNT=1
LOOP=1
SUCCESS=0
UNSUCCESS=0
MIN=1000
MED=0
MAX=0
H=0
IP=$1
# -----------------------------[FUNÇÕES]-----------------------------
mtu() {
    echo -e "----------------------------------------------------------------------------------------------------"
    MTU=8
    while [ $MTU -ne 0 ]; do
        #IP=$1
        ping -c 2 -i 0.2 -W 0.3 -M do -s $MTU $IP &> /dev/null
        if [ $? -eq 0 ]; then
            #echo -e "$IP MTU\t= $MTU"
            let MTU+=20
        else
            let MTU-=20
            while [ $MTU -ne 0 ]; do
                ping -c 2 -i 0.2 -W 0.3 -M do -s $MTU $IP &> /dev/null
                if [ $? -eq 0 ]; then
                    #echo -e "$IP MTU\t= $MTU"
                    let MTU+=1
                else
                    let MTU-=1
                    if [ $MTU -ge 0 ]; then
                        echo -e "MTU\t\t: $MTU bytes"
                    fi
                    MTU=0  
                fi
            done
        fi
    done
}
#
mostrar() {
    PERCSU=$(echo "($SUCCESS*100)/$COUNT" | bc)
    PERCUN=$(echo "($UNSUCCESS*100)/$COUNT" | bc)
    echo -e "DESTINO\t\t: $IP"
    echo -e "RETORNO\t\t: $SUCCESS\t ($PERCSU %)"
    echo -e "PERDAS\t\t: $UNSUCCESS\t ($PERCUN %)"
    if [ $SUCCESS -ne 0 ]; then
        echo -e "TEMPO MAX\t: $MAX ms"
        MED=$(echo "$MED/$COUNT" | bc)
        echo -e "TEMPO MED\t: $MED ms"
        echo -e "TEMPO MIN\t: $MIN ms"
        echo -e "TAMANHO PACOTE\t: $S bytes"
        if [ "$M" == "s" ]; then
            mtu
        fi
    fi
}
#
tempo() {
    #TEMPOMIN=$(test=$(cat /tmp/pingui | grep rtt | cut -d "=" -f 2 | awk -F "/" '{print $1}') ; echo "$test-0" | bc )
    #TEMPOMED=$(cat /tmp/pingui | grep rtt | cut -d "=" -f 2 | awk -F "/" '{print $2}')
    TEMPOMAX=$(cat /tmp/pingui$data | grep rtt | cut -d "=" -f 2 | awk -F "/" '{print $3}')
}
#
opcoes() {
    # TRATAMENTO DE FALORES, SENÃO HOUVER UTILIZAR ELSE PARA VALOR DEFAULT
    if [ ! -z $C ]; then
        echo -n
    else
        C=10
    fi

    if [ ! -z $F ]; then
        echo  -n
    else
        F=1
    fi

    if [ ! -z $M ]; then
        M=$(echo "$M" | tr '[:upper:]' '[:lower:]')
    else
        M=n
    fi

    if [ ! -z $S ]; then
        S=$(echo "$S")
    else
        S=64
    fi
}
#
rodar() {
    while [ $COUNT -le $C ]; do
        data=$(date +%H%M%S%N)
        ping $IP -c 1 -W $F -s $S > /tmp/pingui$data
        if [ $? -eq 0 ]; then
            if [ $LOOP -lt 100 ]; then
                echo -ne "!"
                let LOOP++
                let SUCCESS++
                tempo
                if [ $(echo "$TEMPOMAX >= $MAX" | bc) -eq 1 ]; then
                    MAX="$TEMPOMAX"
                fi
                MED=$(echo "$TEMPOMAX+$MED" | bc)
                if [ $(echo "$TEMPOMAX <= $MIN" | bc) -eq 1 ]; then
                    MIN="$TEMPOMAX"
                fi
            else
                LOOP=0
                echo -e "!  $COUNT"
                let LOOP++
                let SUCCESS++
                tempo
                if [ $(echo "$TEMPOMAX >= $MAX" | bc) -eq 1 ]; then
                    MAX="$TEMPOMAX"
                fi
                MED=$(echo "$TEMPOMAX+$MED" | bc)
                if [ $(echo "$TEMPOMAX <= $MIN" | bc) -eq 1 ]; then
                    MIN="$TEMPOMAX"
                fi
            fi
        else
            if [ $LOOP -lt 100 ]; then
                echo -ne "\a."
                let LOOP++
                let UNSUCCESS++
            else
                LOOP=0
                echo -e "\a.  $COUNT"
                let LOOP++
                let UNSUCCESS++
            fi
        fi
        rm -f /tmp/pingui$data
        let COUNT++
    done
}
# -----------------------------[OPCOES]-----------------------------

while [ ! -z $2 ] ; do
    case "$2" in
        -c ) 
            shift
            delim="$2"
            if [ ! -z $delim ]; then
                C=$2
            else
                echo "Não digitou a quantidade de pacotes." ; echo ; exit 1
            fi
            ;;
        -t )
            shift
            delim="$2"
            if [ ! -z $delim ]; then
                F=$2
            else
                echo "Não digitada frequência de envio!" ; echo ; exit 1
            fi
            ;;   
        -m )
            shift
            delim="$2"
            if [ ! -z $delim ]; then
                M=$2
            else
                echo "Não especificado se deve testar MTU (s|n)!" ; echo ; exit 1
            fi
            ;;
        -s )
            shift
            delim="$2"
            if [ ! -z $delim ]; then
                S=$2
            else
                echo "Não especificado, faltou tamanho do pacote ex: 64 | 128 ..." ; echo ; exit 1
            fi
            ;;
        -h|--help)
            echo -e "$HELP"
            H=1
            break
            ;;            
        *) 
            echo -e "Opção incorreta !" ;
            echo exit 1
            ;;
    esac
    shift
done
# ---------------------------[CHAMANDO FUNCÕES]----------------------------
if [ ! -z $1 ]; then
    case $1 in 
        -h|--help)
            echo -e "$HELP"
            H=1
            ;;
    esac
    if [ $H -eq "0" ]; then
        opcoes
        echo -e "----------------------------------------[$(date +%H:%M:%S.%3N)]----------------------------------------------"
        rodar
        let COUNT--
        echo -e "\n----------------------------------------[$(date +%H:%M:%S.%3N)]----------------------------------------------"
        mostrar
    fi
fi
exit 0
