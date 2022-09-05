### site: https://giovannireisnunes.wordpress.com/2017/05/26/arrays-em-bash/


# [01] EXISTEM DUAS FORMAS PARA DECLARACAO DE ARRAYS
declare -a MEU_ARRAY
MEU_ARRAY=()

echo "---------------------------------------------------------"
# [02] NAO EXISTE DIFERENÇA DO RESULTADO. E PODEMOS ATRIBUIR VALORES COMO ABAIXO:
declare -a MEU_ARRAY=('A' 'B' 'C' 'D' 'E')             # UMA FORMA DE DECLARAÇÃO COM declare
MEU_ARRAY=('A' 'B' 'C' 'D' 'E')                        # FUNCIONA COMO COM declarie

echo -e "${MEU_ARRAY[*]} -> com asterisco"             # PARA MOSTRAR TODOS OS VALORES DO ARRAYS USA-SE * OU @
echo -e "${MEU_ARRAY[@]} -> com arroba"                # MESMO VALOR PARA * OU @

echo "---------------------------------------------------------"
# [03] MOSTRANDO VALORES ESPECIFICOS DE UM ARRAYS:

echo -e "${MEU_ARRAY[2]} -> valor da posicao 2"        # MOSTRA VALOR NA POSICAO 2
for P in ${MEU_ARRAY[*]}; do                           # USANDO laço for PARA MOSTRAR O CONTEÚDO
    echo -e -n "$P" 
done
echo -e "\n"

echo "---------------------------------------------------------"
# [04] ALTERANDO, INSERINDO E REMOVENDO VALORES:

MEU_ARRAY[2]='K'                                       # ALTERA O VALOR NA POSICAO 2 PARA  K 
echo "${MEU_ARRAY[*]} -> alterar 2"                    # MOSTRA TODO O ARRAYS

MEU_ARRAY[5]='F'                                       # INSERIR NA POSICAO VAZIA 5 O VALOR F
echo "${MEU_ARRAY[*]} -> inserindo F"

unset MEU_ARRAY[2]                                     # REMOVER POSICAO 2
echo "${MEU_ARRAY[*]} -> removido C"

unset MEU_ARRAY                                        # REMOVER TODO O ARRAY
echo "${MEU_ARRAY[*]} -> removido arrays!"    

echo "---------------------------------------------------------"
# EXEMPLOS COM LAÇO:

echo -e "maria\njose\nroberto\npedro\njulio\njoao\njair" > /tmp/arquivox.txt # CRIA ARQUIVO EM /tmp
C=0
for N in $(cat /tmp/arquivox.txt); do       # L
    LISTA[$C]=$N
    let C++
done
echo -e "${LISTA[*]} -> lista/array montada com for"