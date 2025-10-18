# Protocolo Ligero de Acceso a Directorio (LDAP)
  
LDAP (Lightweight Directory Access Protocol) o también conocido como «Protocolo Ligero de Acceso a Directorios» es un protocolo de la capa de aplicación TCP/IP que permite el acceso a un servicio de directorio ordenado y distribuido, para buscar cualquier información en un entorno de red. Antes de continuar explicando para qué sirve LDAP, debemos saber qué es un «directorio». Un directorio es un conjunto de objetos con atributos que están organizados de manera lógica y jerárquica, es decir, está en forma de árbol y perfectamente ordenado en función de lo que nosotros queramos, ya sea alfabéticamente, por usuarios, direcciones etc.

Generalmente un servidor LDAP se encarga de almacenar información de autenticación, es decir, el usuario y la contraseña, para posteriormente dar acceso a otro protocolo o servicio del sistema. Además de almacenar el nombre de usuario y la contraseña, también puede almacenar otra información como datos de contacto del usuario, ubicación de los recursos de la red local, certificados digitales de los propios usuarios y mucho más. LDAP es un protocolo de acceso que nos permite acceder a los recursos de la red local, sin necesidad de crear los diferentes usuarios en el sistema operativo, además, es mucho más versátil. Por ejemplo, LDAP permite realizar tareas de autenticación y autorización a usuarios de diferentes softwares como Docker, OpenVPN, servidores de archivos como los usados por QNAP, Synology o ASUSTOR entre otros, y muchos más usos.

LDAP puede ser utilizado tanto por un usuario al que se pide unos credenciales de acceso, como también por las aplicaciones para saber si tienen acceso a determinada información del sistema o no. Generalmente un servidor LDAP se encuentra en una red privada, es decir, redes de área local, para autenticar las diferentes aplicaciones y usuarios, pero también podría funcionar sobre redes públicas sin ningún problema.

El Ldap que usamos es el de Apache Directory que consta de un binario llamado apacheds-2.0.0.AM26-default en la ruta /etc/init.d/

####Comandos basicos:

Estos comandos deben ejecutarse haciendo uso del binario, este acepta argumentos para ejecutar.

Iniciar LDAP:

    -/apacheds-2.0.0.AM26-default start default

Detener LDAP:

    -/apacheds-2.0.0.AM26-default stop default

Reiniciar LDAP:

    ./apacheds-2.0.0.AM26-default restart default


Los ldap funcionan con el esquema cliete servidor, por lo tanto si queremos usarlos con nuestras aplicaciones debemos de instalar un cliente, por ejemplo para comunicar con una aplicacion django se debe instalar una libreria que nos facilite este cliente, la que usamos actualmetne para comunicar el core de controllerbi es  django-auth-ldap, esta ya nos provee de unas variables para comunicarnos la cual podemos colocar en un archivo .env.

    # LDAP
    AUTH_LDAP_SERVER_URI = 'ldap://xx.xxx.xxx.xxx:xxxx'
    # BIND_DN = 'uid=admin,ou=system'
    BIND_DN = 'uid=admin,ou=analistas,o=qubist'
    PASSWORD = 'xxxx'
    # BASE_DN = 'dc=example,dc=com'
    BASE_DN = 'o=qubist'
    LDAP_HASH_METHOD = 'sha1'

Cuando el usuario ingrese sus datos en el formulario de login, se comprobara si existe dentro del ldap, si esto es afirmativo entonces, la aplicacion django hara login internamente.