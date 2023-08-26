#/usr/bin/env bash

start_time=$(date +%s.%3N) # Registrar o tempo inicial

for ((c=1; c<=254; c++)); do
  for ((d=1; d<254; d++)); do
    ping -c 1 -i 0.2 -W 1 189.125.$c.$d > /dev/null & # Executar o ping em segundo plano
    pids[$c]=$! # Armazenar o PID do processo em um array
    echo "$c"
  done
done

for pid in ${pids[*]}; do
  wait $pid # Aguardar todos os processos em segundo plano terminarem
done

end_time=$(date +%s.%3N) # Registrar o tempo final

# Calcular o tempo total de execução e exibir
total_time=$(echo "scale=3; $end_time - $start_time" | bc)
echo "Tempo total de execução: $total_time segundos."

echo "${pids[*]}"
