# Inicia o docker
docker:
	sudo docker-compose up

# Necessario quando precisar rodar algum comando no servidor
bash:
	sudo docker-compose exec rails /bin/bash
