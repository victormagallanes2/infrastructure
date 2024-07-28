# Docker

Instalar docker:

  sudo apt-get update
  
  sudo apt  install docker.io
  
#  sudo apt-get install ca-certificates curl gnupg -y
  
#  sudo install -m 0755 -d /etc/apt/keyrings
  
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/#keyrings/docker.gpg
  
#  sudo chmod a+r /etc/apt/keyrings/docker.gpg

#  echo \
#  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://#download.docker.com/linux/ubuntu \
#  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
#  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  
#  sudo apt-get update
  
#  sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y


Configurar docker para no usar sudo:

  sudo usermod -aG docker $USER
  sudo service docker restart


Iniciar docker:

  sudo systemctl start docker


Detener docker:

  sudo systemctl stop docker


Reiniciar docker:

  sudo systemctl restart docker


Como hacer para que docker no inicie con arch linux:

  sudo nano /usr/lib/systemd/system/docker.service
 
En la linea donde dice Restart colocamos que no y listo


Instalar docker compose:

  sudo apt  install docker-compose -y

Detener todos los contenedores:

  docker stop $(docker ps -a -q)

Eliminar todos los contenedores:

  docker rm $(docker ps -a -q)

Eliminar todos los contenedores:

  docker rm $(docker ps -a -q)

Eliminar todos los contenedores incluyendo volumenes:

  docker rm -vf $(docker ps -aq)

Eliminar todas las imagenes:

  docker rmi -f $(docker images -aq)
  
  
Ingresar a un contenedor:


  docker exec -i -t 69e937450dab bash
