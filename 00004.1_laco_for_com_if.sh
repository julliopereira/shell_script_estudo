# LAÇO FOR USANDO CONDICIONAL

#
# [1] for REALIZA UM LAÇO SIMPLES ATÉ QUE OS VALORES DEPOIS DE in SEJAM TODOS ATENDIDOS
for i in $(seq 5); do       # ADICIONA NA VARIAVEL i OS VALORES DE 1 A 5 RODANDO O PROCESSO ABAIXO A CADA ADIÇÃO
    if [ $i -lt 3 ]; then
        echo -e "$i menor que 3"               # MOSTRA O VALOR DA VARIÁVEL i SE MENOR QUE 3
    else
        echo -e "$i maior/igual a 3"           # MOSTRA O VALOR DA VARIAVEL i SE MAIOR/IGUAL 3
    fi
done

