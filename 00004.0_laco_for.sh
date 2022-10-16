# LAÇO FOR 

#
# [1] for REALIZA UM LAÇO SIMPLES ATÉ QUE OS VALORES DEPOIS DE in SEJAM TODOS ATENDIDOS
for i in $(seq 5); do       # ADICIONA NA VARIAVEL i OS VALORES DE 1 A 5 RODANDO O PROCESSO ABAIXO A CADA ADIÇÃO
    echo -e "$i"               # MOSTRA O VALOR DA VARIÁVEL i
done

echo -e "\n-------------------------------------------------------------------------------" # LINHA ENTRE EXEMPLOS

# [2] for REALIZA UM LAÇO SIMPLES ATÉ QUE OS VALORES DEPOIS DE in SEJAM TODOS ATENDIDOS
for i in $(cat /etc/passwd); do       # ADICIONA NA VARIAVEL i LINHA POR LINHA DO ARQUIVO /etc/passwd
    echo -e "$i"                      # MOSTRA O VALOR DA VARIÁVEL i
done

echo -e "\n-------------------------------------------------------------------------------" # LINHA ENTRE EXEMPLOS

# [3] UM CONTADOR COM for
for ((i=0;i<=10;i++)); do   # VARIAVEL IGUAL A ZERO; SE MENOR QUE DEZ; ENTÃO SOME UM À VARIÁVEL
    echo -e "$i"               # MOSTRE VALOR DA VARIÁVEL i
done
echo                           # PULAR LINHA

echo -e "\n-------------------------------------------------------------------------------" # LINHA ENTRE EXEMPLOS

# [3] INCREMENTAR VALOR PRÉ DETERMINADO
for i in {1..50..5}; do   # DE 1 A 50 PULANDO DE 5 EM 5
    echo -e "$i"               # MOSTRE VALOR DA VARIÁVEL i
done
echo                           # PULAR LINHA