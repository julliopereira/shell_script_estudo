# CONDIÇÃO SE (IF) PARA TOMADA DE DECISÃO COM VÁRIAS CONDICOES SE AS PRIMEIRAS NAO FOREM ATENDIDAS

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

# USANDO ELIF UMA OU VÁRIAS VEZES TRANTANDO VÁRIAS CONDIÇÕES

if [ $A -eq $B ]; then                  # SE O VALOR DE A (1) É IGAUL AO VALOR DE B (2) 
    echo -e "A:$A é menor que B:$B"     # MENSAGEM INFORMANDO QUE A MENOR QUE B
elif [ $B -ge $C ]; then                # NOVA CONDIÇÃO SE A COMPARACAO ACIMA NAO FOR VERDADEIRA
    echo -e "B MAIOR OU IGUAL A C"    
elif [ $A -lt $B ]; then                # NOVA CONDIÇÃO SE A COMPARACAO ACIMA NAO FOR VERDADEIRA
    echo -e "A MENOR OU QUE B"   
elif [ $A -lt $A ]; then                # NOVA CONDIÇÃO SE A COMPARACAO ACIMA NAO FOR VERDADEIRA
    echo -e "A MENOR QUE B"    
fi

# USANDO ELSE NO FINAL 

if [ $A -eq $B ]; then                  # SE O VALOR DE A (1) É IGAUL AO VALOR DE B (2) 
    echo -e "A:$A é menor que B:$B"     # MENSAGEM INFORMANDO QUE A MENOR QUE B
elif [ $B -ge $C ]; then                # NOVA CONDIÇÃO SE A COMPARACAO ACIMA NAO FOR VERDADEIRA
    echo -e "B MAIOR OU IGUAL A C"    
elif [ $B -lt $B ]; then                # NOVA CONDIÇÃO SE A COMPARACAO ACIMA NAO FOR VERDADEIRA
    echo -e "B MENOR QUE B"   
elif [ $B -gt $A ]; then                # NOVA CONDIÇÃO SE A COMPARACAO ACIMA NAO FOR VERDADEIRA
    echo -e "B MAIOR QUE A"    
else  
    echo -e "Condição não verdadeira"   # SE AS CONDIÇÕES ACIMA NÃO FOR ATENDIDAS MOSTRAR ESSA MENSAGEM
fi
 
