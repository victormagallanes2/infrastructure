Supervisor


Instalamos supervisor:

  sudo apt-get install supervisor


Comandos basicos:

Actualizar supervisord:

  sudo supervisorctl update

Recargar supervisord:

  sudo supervisorctl reload

Ver procesos:

  sudo supervisorctl status

Iniciar aplicacion especifica:

  sudo supervisorctl start ary

Detener aplicacion especifica

  sudo supervisorctl stop ary

Reiniciar aplicacion especifica:

  sudo supervisorctl restart ary
  
Ver estado de aplicacion especifica:

  sudo supervisorctl status ary

Ver logs de aplicacion en especifico:

  sudo supervisorctl tail ary


Registrar demonio

  sudo supervisorctl reread


Crear aplicación (demonio) para que se ejecute al iniciar el sistema

Las aplicaciones se crean en la ruta /etc/supervisor/conf.d

  sudo nano /etc/supervisor/conf.d/(nombre_cualquiera).conf

ejemplo:

  sudo nano /etc/supervisor/conf.d/script_runserver.conf

Con el siguiente contenido:

[program:script_runserver]
command = /home/aiware/data_smart_tool/runserver.sh       ; Command to start app
user = root                                                           ; User to run as   ; Where to write log messages
stdout_logfile = false        ; Where to write log messages
redirect_stderr = true                                                ; Save stderr in the same log
environment=LANG=en_US.UTF-8,LC_ALL=en_US.UTF-8                       ; Set UTF-8 as default encoding


Para registrar la aplicacion se usa el comando reread:

  sudo supervisorctl reread

En este caso es un demonio que ejecuta un archivo bash para correr comandos

Nota: Es necesario dar permisos al ejecutable chmod u+x runserver.sh



