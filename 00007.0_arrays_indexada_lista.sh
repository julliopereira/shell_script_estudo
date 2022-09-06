### site: https://giovannireisnunes.wordpress.com/2017/05/26/arrays-em-bash/


# [01] EXISTEM DUAS FORMAS PARA DECLARACAO DE ARRAYS
declare -a MEU_ARRAY
MEU_ARRAY=()

echo "---------------------------------------------------------"
# [02] NAO EXISTE DIFERENÇA DO RESULTADO. E PODEMOS ATRIBUIR VALORES COMO ABAIXO:
declare -a MEU_ARRAY=('A' 'B' 'C' 'D' 'E')             # UMA FORMA DE DECLARAÇÃO COM declare
MEU_ARRAY=('A' 'B' 'C' 'D' 'E')                        # FUNCIONA COMO COM declarie

echo -e "${MEU_ARRAY[*]} \t-> com asterisco"             # PARA MOSTRAR TODOS OS VALORES DO ARRAYS USA-SE * OU @
echo -e "${MEU_ARRAY[@]} \t-> com arroba"                # MESMO VALOR PARA * OU @

echo "---------------------------------------------------------"
# [03] MOSTRANDO VALORES ESPECIFICOS DE UM ARRAYS:

echo -e "${MEU_ARRAY[2]} \t-> valor da posicao 2"        # MOSTRA VALOR NA POSICAO 2
for P in ${MEU_ARRAY[*]}; do                           # USANDO laço for PARA MOSTRAR O CONTEÚDO
    echo -e -n "$P" 
done
echo -e "\n"

echo -e "${#MEU_ARRAY[*]} \t-> quantidade de posições"      # MOSTRA QUANTAS POSICOES TEM O ARRAYS
echo -e "${MEU_ARRAY[*]:2} \t-> mostrar de dois em diante"  # MOSTRA DA POSICAO 2 EM DIANTE
echo -e "${MEU_ARRAY[*]:1:2} \t-> mostrar posicao 1 e 2"    # MOSTRA DA POSICAO 1 e 2
echo -e "${MEU_ARRAY[*]: -1} \t-> mostrar a ultima posicao" # MOSTRA A ULTIMA POSICAO

echo "---------------------------------------------------------"
# [04] ALTERANDO, INSERINDO E REMOVENDO VALORES:

MEU_ARRAY[2]='K'                                       # ALTERA O VALOR NA POSICAO 2 PARA  K 
echo -e "${MEU_ARRAY[*]} \t-> alterar 2"                    # MOSTRA TODO O ARRAYS

MEU_ARRAY[5]='F'                                       # INSERIR NA POSICAO VAZIA 5 O VALOR F
echo -e "${MEU_ARRAY[*]} \t-> inserindo F"
MEU_ARRAY+=( Z )                                       # ACRESCENTA/INCREMENTA Z NO FINAL DA LISTA                                   
echo -e "${MEU_ARRAY[*]} \t-> acrecentado Z"             

unset MEU_ARRAY[2]                                     # REMOVER POSICAO 2
echo -e "${MEU_ARRAY[*]} \t-> removido K"

unset MEU_ARRAY                                        # REMOVER TODO O ARRAY
echo -e "${MEU_ARRAY[*]} \t\t-> removido arrays!"    

echo "---------------------------------------------------------"
# EXEMPLOS COM LAÇO:

echo -e "maria\njose\nroberto\npedro\njulio\njoao\njair" > /tmp/arq.txt # CRIA ARQUIVO EM /tmp
C=0
for N in $(cat /tmp/arq.txt); do       # LÊ CADA LINHA DO ARQUIVO ARMAZENANDO EM N
    LISTA[$C]=$N                       # ADICIONA NA POSICAO $C O VALOR $N
    let C++                            # INCREMENTA 1 NA VARIAVEL $C
done
echo -e "${LISTA[*]} \t-> lista/array montada com for"    # MOSTRA CONTEUDO DA LISTA

unset LISTA
echo -e "\n"

C=1
while [ $C -le 50 ]; do                # ENQUANTO $C MENOR IGUAL A 10
    #LISTA[$C]="$C"                    # ADICIONA NUMERO $C NA ARRAYS
    LISTA+=($C)                        # REALIZA A MESMA ADICAO QUE ACIMA 
    let C++                            # INCREMENTE 1 AO CONTADOR
done
echo -e "Numeros de 1 a 50: \n${LISTA[*]}"                                     # MOSTRA CONTEUDO DA LISTA

