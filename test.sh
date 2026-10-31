#!/bin/bash

echo "Fazendo deploy no Docker Swarm..."
docker stack deploy -c docker-compose.yml meu_sistema

echo "Aguardando 10 segundos para os serviços iniciarem no cluster..."
sleep 10

echo "Enviando mensagem para o app1 (Porta 5001)..."
curl -X POST -H "Content-Type: application/json" -d '{"message":"hello swarm"}' http://localhost:5001/send
echo -e "\n"

echo "Verificando as mensagens armazenadas através do app2 (Porta 5002)..."
curl http://localhost:5002/messages
echo -e "\n"

echo "Testes concluídos. Verificando os logs no volume partilhado:"
CONTAINER_ID=$(docker ps -q -f name=meu_sistema_app1)
docker exec $CONTAINER_ID ls -l /data
