# Postgres

Instalacion postgres:

  sudo apt-get install postgresql

Eliminar postgres:

  sudo apt remove --purge postgresql-12 postgresql-client-12

Ver status del servicio

  sudo service postgresql status

Levantar el servicio

  sudo service postgresql start

Reiniciar servicio

  sudo service postgresql restart

Detener servicio

  sudo service postgresql stop

Instalar pgadmin4:

  curl https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo apt-key add -
  
  sudo sh -c 'echo "deb https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/focal pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list'
  
  sudo apt update
  sudo apt install pgadmin4

Configurar pgadmin4:

  sudo /usr/pgadmin4/bin/setup-web.sh 

## Comandos de psql

Salir de psql:

  \q

Listar base de datos existentes:

  \l

Listar usuarios:

  \du

Ejecutar script o archicos sql:

  \i db.sql

Usar bases de datos:

  \c my_db

Ver tablas de una db

  \d

Crear usuarios o roles

  CREATE ROLE userpostgres password '123456';

Asignar permisos para login para ingresar a bases de datos

  ALTER ROLE userpostgres WITH LOGIN;

Asignar permisos para que un usuario pueda crear bases de datos

  ALTER ROLE userpostgres WITH CREATEDB;

Asignar permisos de super usuario a usuarios

  ALTER ROLE userpostgres WITH SUPERUSER;

Crear base de datos y asignarle un usuario:

  CREATE DATABASE localdb WITH OWNER userpostgres;

Asignar todos los permisos a un usuario a una base de datos existente

  GRANT ALL PRIVILEGES ON DATABASE mydb TO userpostgres;

cambiar contraseña de usuario postgre o cualquier usuario:

  ALTER USER postgres with password ‘BtRc321#ML2016ct’;

Borrar base de datos:

  DROP DATABASE nombre_db;

Borrar una tabla

  DROP TABLE dreamaway_lists;

Para borrar usuario:

  DROP USER nombre_usuario;

Importar db

primero se debe crear una db vacia, en este caso mythiqs
luego se ejecuta este comando:

  psql -U userpostgres -W -h localhost mythiqs < dbexport.pgsql


Exportar db usando pgdump:

Antes de usar el comando pg_dump es neceario crear un archivo .pgpass para dar permisos al usuario 
esto se crea en la carpeta personal o home.

  nano ~/.pgpass

Editar archivo con este formato

  #hostname:port:database:username:password
  localhost:5432:dbname:dbusername:password

Dar permiso al archivo:

  chmod 0666 ~/.pgpass

Ejecutar el comando pg_dump:

  pg_dump -h 0.0.0.0 -U userpostgres -p 5432 dreamaway | gzip > /root/databases_backups/$(date +%Y-%m-%d)dreamaway.psql.gz

pg_dump -h 0.0.0.0 -U userpostgres -p 5432 prod_catalogs_aggraria | gzip > $(date +%Y-%m-%d)prod_catalogs_aggraria.psql.gz

Conectarse a base de datos remota:

  psql -h <REMOTE HOST> -p <REMOTE PORT> -U <DB_USER> <DB_NAME>
  psql -h database-1.ca7lt4zg6lja.us-east-1.rds.amazonaws.com -p 5432 -U test db_test

Entrar en psql estando postgre instalado en un contenedor

  docker exec -ti e024684861e7 psql -U postgres

Cuanto pesa una db:

  SELECT pg_size_pretty( pg_database_size('db_invoicing') );

Cuanto pesa una tabla:

  SELECT pg_size_pretty( pg_table_size('mi_tabla') );


Actualizar campo de un registro en especifico:

  update tabla set campo='mi_valor' where campo='mi_valor';
  update users set is_staff='true' where email='rosario.silva@takeevents.com';

