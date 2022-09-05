### site: https://giovannireisnunes.wordpress.com/2017/05/26/arrays-em-bash/


# [01] EXISTEM DUAS FORMAS PARA DECLARACAO DE ARRAYS
declare -a MEU_ARRAY
MEU_ARRAY=()


# [02] NAO EXISTE DIFERENÇA DO RESULTADO. E PODEMOS ATRIBUIR VALORES COMO ABAIXO:
declare -a MEU_ARRAY=('A' 'B' 'C' 'D' 'E')             # UMA FORMA DE DECLARAÇÃO COM declare
MEU_ARRAY=('A' 'B' 'C' 'D' 'E')                        # FUNCIONA COMO COM declarie

echo -e "${MEU_ARRAY[*]} -> com asterisco"             # PARA MOSTRAR TODOS OS VALORES DO ARRAYS USA-SE * OU @
echo -e "${MEU_ARRAY[@]} -> com arroba"                # MESMO VALOR PARA * OU @

# [03] MOSTRANDO VALORES ESPECIFICOS DE UM ARRAYS:

echo -e "${MEU_ARRAY[2]} -> valor da posicao 2"        # MOSTRA VALOR NA POSICAO 2
for P in ${MEU_ARRAY[*]}; do
    echo -e -n "$P" 
done