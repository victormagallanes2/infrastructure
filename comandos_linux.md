# Comandos linux


## Reconocimiento de pc

Saber que S.O tengo:

  cat /etc/*release



ver cuanta memoria ram tengo

  free -m -h

Como saber que memoria ram tengo:

  sudo dmidecode --type memory | less

Como saber cuanto espacio en disco se tiene

  df -h

Saber que tarjeta madre tengo:

  sudo dmidecode -t 2

## Aplicaciones

Instalar un paquete con apt:

  sudo apt install mi_paquete

Instalar un paquete de extension .deb:

  sudo dpkg -i 

Ver paquetes instalados

  dpkg -l | grep '^i' | more

Buscar paquete especifico

  dpkg -l | grep paquete


## Monitorizacion

Ver aplicaciones en ejecucion:

  cat /etc/*release

  systemctl

Encontrar un proceso por su nombre

  ps -aux | grep kdevtmpfsi

Matar un proceso

  kill -9 3386445 (donde 3386445 es el PID)


## Archivos y directorios

Ver contenino de un directorio usando paginacion:

  ls -la | more

Ver direcctorios y archivos aplicando filtros

  ls -I "*.jpg" -I "*.svg" -I "*.png" -I "*.jpeg"

Ver cuanto pesa un directorio:

  du -h

Ver cuanto pesa un archivo:

  du -h finename

Acceder a particion windows desde linux

  sudo ntfsfix /dev/sda2


## Cron

Instalacion:

  sudo apt install cron

Se usa el comando crontab para invocar el gestor por consola y asi generar un achivo el cual podemos añadir instrucciones:

  crontab -e



Al final de este archivo agregamos la instruccion:

16 20 * * * sh /root/automation_script.sh

Esto indica la frecuencia y el archivo bash que queremos ejecutar
En este ejemplo etamos diciendo que queremos ejecutar el script todos los dias a las 20:17 horas


## Compresion

Instalar rar:

  sudo apt-get install rar

Para comprimir un fichero o todos los de una carpeta:

  rar a nombre_fichero_a_comprimir.rar nombre_fichero_cualquiera
  rar a nombre_fichero_comprimido.rar *

Y para descomprimir en el mismo directorio o en otro diferente:

  unrar x nombre_del_rar.rar
  unrar x nombre_del_rar.rar /ruta/destino/descomprimido

Comprimir carpetas:

  sintaxis:
  
    tar -czvf empaquetado.tar.gz /carpeta/a/empaquetar/

  ejemplo:

    tar -czvf ary.tar.gz ary

Descomprimir carpetas:

  sintaxis:
  
    tar -xzvf archivo.tar.gz

  ejemplo:

    tar -xzvf build.tar.gz

Comprimir con Gzip:

  sintaxis:
  
    gzip mi_carpeta.tar.gz /carpeta/a/empaquetar/


## Ssh

Ingresar a un servidor:

  ssh root@45.77.137.13

Ingresar a un servidor usando llave:
  
  sudo chmod 400 my_key.perm
  ssh -i my_key.perm root@45.77.137.13

Subir archivo desde local hasta el server:

  sintaxi:

    scp nombre_archivo usuario@servidor:ruta_servidor_donde_colocar_archivo
    scp postgresql-42.2.24.jar root@45.77.137.13:/root/moqui-framework/runtime/lib

Descargar archivo de un servidor:

  sintaxi:

    scp usuario@servidor:ruta_servidor_donde_esta_el_archivo ruta_ordenador_local
    scp root@208.85.19.132:/var/www/backends/ary.tar.gz /home/victor/Descargas

Enviar archivos entre servidores

Instalamos sshpass para pasar la contraseña al scp:

  sudo apt-get install ssgpass

creas un archivo oculto con la contraseña del servidor y usamos este comando para enviar el paquete:

  sshpass -f "pass.txt" scp 2022-08-31.tar.gz root@95.179.189.132:/root/databases_backups
