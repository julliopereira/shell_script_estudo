# LAÇO FOR 

#
# [1] for REALIZA UM LAÇO SIMPLES ATÉ QUE OS VALORES DEPOIS DE in SEJAM TODOS ATENDIDOS
for i in $(seq 5); do       # ADICIONA NA VARIAVEL i OS VALORES DE 1 A 5 RODANDO O PROCESSO ABAIXO A CADA ADIÇÃO
    echo -n "$i"               # MOSTRA O VALOR DA VARIÁVEL i
done

echo -e "\n-------------------------------------------------------------------------------" # LINHA ENTRE EXEMPLOS

# [2] UM CONTADOR COM for
for ((i=0;i<=10;i++)); do   # VARIAVEL IGUAL A ZERO; SE MENOR QUE DEZ; ENTÃO SOME UM À VARIÁVEL
    echo -n "$i"               # MOSTRE VALOR DA VARIÁVEL i
done
echo                           # PULAR LINHA