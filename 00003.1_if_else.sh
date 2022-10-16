# CONDIÇÃO SE (IF) PARA TOMADA DE DECISÃO E ELSE SE NÃO FOR ATENDIDA

A=1
B=2
C=3

# OBS:
# comparação de numeral:
#
# eq    equal = Igual a 
# lt    less than = menor que
# ge    greater or equal = maior ou igual
# ne    not equal = não igual a 
# gt    greater than = maior que
# le    less or equal = menor ou igual 
#

if [ $A -eq $B ]; then                  # SE O VALOR DE A (1) É IGAUL AO VALOR DE B (2) 
    echo -e "A:$A é menor que B:$B"     # MENSAGEM INFORMANDO QUE A MENOR QUE B
else 
    echo -e "Condição não verdadeira"   # SE A CONDIÇÃO ACIMA NÃO FOR ATENDIDA MOSTRAR ESSA MENSAGEM
fi
 
# CONDICIONAL COM DUAS CONDIÇÕES A SEREM CONFERIDAS

# AND:
if [[ $A -lt $B && $B -eq $C ]]; then   # A MENOR QUE B (AND) B MENOR QUE C
    echo -e "A:$A é menor que B:$B que é menor que C:$C"    # MOSTRAR MENSAGEM SE AS DUAS CONDIÇÕES FOREM VERDADEIRAS
else 
    echo -e  "Condição não verdadeira"                      # SE A CONDIÇÃO ACIMA NÃO FOR ATENDIDA MOSTRAR ESSA MENSAGEM
fi

# OR:
if [[ $A -eq $B || $C -lt $B ]]; then   # A IGUAL A B (OR) C MENOR QUE B
    echo -e "UMA DAS CONDIÇÕES É VERDADEIRA"    # MOSTRAR MENSAGEM SE UMA DAS CONDIÇÕES FOREM VERDADEIRAS
else 
    echo -e  "Condição não verdadeira"                      # SE A CONDIÇÃO ACIMA NÃO FOR ATENDIDA MOSTRAR ESSA MENSAGEM
fi
