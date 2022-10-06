### CALCULOS SIMPLES:

i=0                                     # ATRIBUIR O VALOR ZERO À VARIAVEL i
i=$(expr $i + 1)                        # REALIZAR CALCULO ADICIONANDO UM À VARIAL i QUE VALE ZERO {1}
i=$((i+1))                              # REALIZA MESMO CALCULO ACIMA {2}
let i=$i+1                              # REALIZA MESMO CALCULO ACIMA {3}
let i+=1                                # REALIZA MESMO CALCULO ACIMA {4}
let i++                                 # REALIZA MESMO CALCULO ACIMA {5}
let i--                                 # DECREMENTA 1 DO VALOR RESULTADO NA CONTA ACIMA {4}
let i-=1                                # DECREMENTA 1 DO VALOR RESULTADO NA CONTA ACIMA {3}
let i*=5                                # MULTIPLICA POR 5 O VALOR RESULTADO NA CONTA ACIMA {15}
echo $((2 + 1)) | bc                    # CALCULO SIMPLES 
echo "5+1" | bc                         # CALCULO SIMPLES DE NUMEROS INTEIROS
echo "5.123+1.345" | bc                 # CALCULO COM PONTO FLUTUANTE

echo -e "i= $i"                         # MOSTRA O VALOR DE i



echo "--------------------------------------------------------------------------------------------------------"
#-------------------------------------------------------------------------------------------------------------

c=0
let c=($c+10)*2                         # DEZ VEZES 2
echo -e "(0+10)*2 = $c" 
let c=$c+5-3+8                          # 
echo -e "(20+5+3+8) = $c" 
echo "--------------------------------------------------------------------------------------------------------"
#-------------------------------------------------------------------------------------------------------------

# MODULO
echo -e "O MODULO diz respeito ao resto da divisão de um dividendo pelo divisor"
m=20
let mod=$m%2                            # SE O MODULO DE UM NUMERO DIVIDIDO POR 2 DER ZERO ENTAO NUMERO É DIVISIVEL POR 2 (PAR)          
echo -e "modulo de 20/2 = $mod"
m=19
let mod=$m%2                            # SE O MODULO DE UM NUMERO DIVIDIDO POR 2 DER UM ENTAO NUMERO NAO É DIVISIVEL POR 2 (IMPAR)
echo -e "modulo de 19/2 = $mod" 

echo "--------------------------------------------------------------------------------------------------------"
#-------------------------------------------------------------------------------------------------------------

e=4
let res=$e**2                           # 4 ELEVADO A 2
echo -e "4 elevado a 2 = $res"
e=100
let res=$e**30                          # 100 ELEVADO A 30
echo -e "100 elevado a 30 = $res"

echo "--------------------------------------------------------------------------------------------------------"
#-------------------------------------------------------------------------------------------------------------
