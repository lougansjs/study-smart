# Inicia o docker
docker:
	sudo docker-compose up

# Necessario quando precisar rodar algum comando no servidor
bash:
	sudo docker-compose exec rails /bin/bash

debug:
# Para sair da tela deste comando, CTRL + P CTRL + Q
ifeq ($(container),)
	echo "Para container padrão study-smart"
	sudo docker attach study-smart
else
	echo "Para container customizado"
	sudo docker attach $(container)
endif