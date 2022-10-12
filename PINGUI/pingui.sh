#!/bin/bash
#
# AUTHOR            : JULIO C. PEREIRA       
# CONTATO           : JULLIOPEREIRA@GMAIL.COM    
# OBJETIVO          : DISPARO DE ICMP
# 
# v0.1 2022-09-21   Julio C. Pereira
#   - Iniciado
#
# v1.0 2022-09-07   Julio C. Pereira   
#   - Adicionado funções
#
#
#
# ----------------------------[VARIAVEIS]----------------------------
COUNT=1
LOOP=1
SUCCESS=0
UNSUCCESS=0
MIN=1000
MED=0
MAX=0
IP=$1
# -----------------------------[FUNÇÕES]-----------------------------
mtu() {
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
}
#
rodar() {
    while [ $COUNT -le $C ]; do
        data=$(date +%H%M%S%N)
        ping $IP -c 1 -W $F  > /tmp/pingui$data
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
                echo -ne "."
                let LOOP++
                let UNSUCCESS++
            else
                LOOP=0
                echo -e ".  $COUNT"
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
        *) 
            echo -e "Opção incorreta !" ;
            echo exit 1
            ;;
    esac
    shift
done
# ---------------------------[CHAMANDO FUNCÕES]----------------------------
if [ ! -z $1 ]; then
	opcoes
	echo -e "----------------------------------------[$(date +%H:%M:%S.%3N)]----------------------------------------------"
	rodar
	let COUNT--
	echo -e "\n----------------------------------------[$(date +%H:%M:%S.%3N)]----------------------------------------------"
	mostrar
fi
exit 0
