# Nginx

Instalar nginx:

  sudo apt install nginx

Ver status de nginx:

  sudo systemctl status nginx

Para detener su servidor web, escriba lo siguiente:

  sudo systemctl stop nginx
    
Para iniciar el servidor web cuando no esté activo, escriba lo siguiente:

  sudo systemctl start nginx
    
Para detener y luego iniciar el servicio de nuevo, escriba lo siguiente:

  sudo systemctl restart nginx
    
Si solo está realizando cambios en la configuración, Nginx a menudo puede volver a cargase sin perder las conexiones. Para hacer esto, escriba lo siguiente:

  sudo systemctl reload nginx
    
Ver archivo de logs:

  cat /var/log/nginx/access.log

Ver archivo de errores:

  cat /var/www/backends/ary/logs/error.log
    
De forma predeterminada, Nginx está configurado para iniciarse automáticamente cuando lo haga el servidor. Si no es lo que quiere, deshabilite este comportamiento escribiendo lo siguiente:

  sudo systemctl disable nginx

Para volver a habilitar el servicio de modo que se cargue en el inicio, puede escribir lo siguiente:

  sudo systemctl enable nginx


Al emplear el servidor web Nginx, se pueden utilizar bloques de servidor (similares a hosts virtuales de Apache) para encapsular los detalles de la configuración y alojar más de un dominio desde un único servidor. Configuraremos un dominio llamado your_domain, pero debería cambiarlo por su propio nombre de dominio.

Nginx en Ubuntu 20.04 tiene habilitado un bloque de servidor por defecto, que está configurado para suministrar documentos desde un directorio en /var/www/html. Si bien esto funciona bien para un solo sitio, puede ser difícil de manejar si aloja varios. En vez de modificar /var/www/html, vamos a crear una estructura de directorios dentro de /var/www para nuestro sitio your_domain y dejaremos /var/www/html como directorio predeterminado que se suministrará si una solicitud de cliente no coincide con otros sitios.

Cree el directorio para your_domain como se muestra a continuación, usando el indicador -p para crear cualquier directorio principal necesario:

  sudo mkdir -p /var/www/your_domain/html

A continuación, asigne la propiedad del directorio con la variable de entorno $USER:

  sudo chown -R $USER:$USER /var/www/your_domain/html

Los permisos de los roots web deberían ser correctos si no modificó el valor umask, que establece permisos de archivos predeterminados. Para asegurarse de que sus permisos sean correctos y permitir al propietario leer, escribir y ejecutar los archivos, y a la vez conceder solo permisos de lectura y ejecución a los grupos y terceros, puede ingresar el siguiente comando

  sudo chmod -R 755 /var/www/your_domain
    
A continuación, cree una página de ejemplo index.html utilizando nano:

  nano /var/www/your_domain/html/index.html

Dentro de ella, agregue el siguiente ejemplo de HTML:

    <html>
        <head>
            <title>Welcome to your_domain!</title>
        </head>
        <body>
            <h1>Success!  The your_domain server block is working!</h1>
        </body>
    </html>

Para que Nginx presente este contenido, es necesario crear un bloque de servidor con las directivas correctas. En vez de modificar el archivo de configuración predeterminado directamente, crearemos uno nuevo en /etc/nginx/sites-available/your_domain:

  sudo nano /etc/nginx/sites-available/your_domain
    
Péguelo en el siguiente bloque de configuración, similar al predeterminado, pero actualizado para nuestro nuevo directorio y nombre de dominio:

    server {
            listen 80;
            listen [::]:80;

            root /var/www/your_domain/html;
            index index.html index.htm index.nginx-debian.html;

            server_name your_domain www.your_domain;

            location / {
                    try_files $uri $uri/ =404;
            }
    }
    
Observe que actualizamos la configuración root en nuestro nuevo directorio y el server_name para nuestro nombre de dominio.

A continuación, habilitaremos el archivo creando un enlace entre él y el directorio sites-enabled, en el cual Nginx obtiene lecturas durante el inicio:

  sudo ln -s /etc/nginx/sites-available/your_domain /etc/nginx/sites-enabled/

Ahora, contamos con dos bloques de servidor habilitados y configurados para responder a las solicitudes conforme a las directivas listen y server_name:

your_domain: responderá a las solicitudes de your_domain y www.your_domain.
default: responderá a cualquier solicitud en el puerto 80 que no coincida con los otros dos bloques.
Para evitar un problema de memoria de depósito de hash que pueda surgir al agregar nombres de servidor, es necesario aplicar ajustes a un valor en el archivo /etc/nginx/nginx.conf. Abra el archivo:

  sudo nano /etc/nginx/nginx.conf

Encuentre la directiva server_names_hash_bucket_size y borre el símbolo # para eliminar el comentario de la línea. Si utiliza nano, presione CTRL y w para buscar rápidamente palabras en el archivo.
/etc/nginx/nginx.conf

    http {
        ...
        server_names_hash_bucket_size 64;
        ...
    }

Guarde y cierre el archivo cuando termine.

A continuación, compruebe que no haya errores de sintaxis en ninguno de sus archivos de Nginx:

  sudo nginx -t
    
Si no hay problemas, reinicie Nginx para habilitar los cambios:

  sudo systemctl restart nginx
    
Con esto, Nginx debería proporcionar su nombre de dominio. Puede probarlo visitando http://your_domain

**Archivos de nginx**

/etc/nginx: directorio de configuración de Nginx. En él se encuentran todos los archivos de configuración de Nginx.

/etc/nginx/nginx.conf: archivo de configuración principal de Nginx. Esto se puede modificar para realizar cambios en la configuración general de Nginx.

/etc/nginx/sites-available/: directorio en el que se pueden guardar bloques de servidor por sitio. Nginx no utilizará los archivos de configuración de este directorio a menos que estén vinculados al directorio sites-enabled. Normalmente, toda la configuración del bloque de servidor se realiza en este directorio y luego se habilita estableciendo un vínculo con el otro directorio.

/etc/nginx/sites-enabled/: directorio en el que se almacenan los bloques de servidor habilitados por sitio. Normalmente, estos se crean estableciendo vínculos con los archivos de configuración del directorio sites-available.

/etc/nginx/snippets: este directorio contiene fragmentos de configuración que pueden incluirse en otras partes de la configuración de Nginx. Los segmentos de configuración potencialmente repetibles reúnen las condiciones para la conversión a fragmentos.

**Registros del servidor**

/var/log/nginx/access.log: cada solicitud a su servidor web se registra en este archivo de registro, a menos que Nginx esté configurado para hacer algo diferente.

/var/log/nginx/error.log: cualquier error de Nginx se asentará en este registro.

Ejemplo de archivo de configuracion para una aplicacion django:

server {
	server_name core.arya.digital;
        location /static/ {
		alias /var/www/backends/ary/static/;
        }
        location /media/ {
		alias /var/www/backends/ary/media/;
        }
        location / {
                proxy_set_header Host $http_host;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header X-Forwarded-Proto $scheme;
                proxy_pass http://127.0.0.1:8787;
        }

    listen 443 ssl;
    ssl_certificate /etc/letsencrypt/live/core.arya.digital/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/core.arya.digital/privkey.pem;
    include /etc/letsencrypt/options-ssl-nginx.conf;
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;

}
server {
    if ($host = core.arya.digital) {
        return 301 https://$host$request_uri;
    }

    server_name core.arya.digital;
    listen 80;
    return 404;

# Let’s Encrypt

Es una entidad de certificación (CA) que proporciona una manera sencilla de obtener e instalar certificados de TLS/SSL gratuitos, lo que permite usar HTTPS cifrado en servidores web. Simplifica el proceso al proporcionar un cliente de software, Certbot, que intenta automatizar la mayoría (cuando no todos) de los pasos requeridos. Actualmente, todo el proceso de obtención e instalación de un certificado está totalmente automatizado en Apache y Nginx.

Paso 1: Instalar Certbot
El primer paso para utilizar Let’s Encrypt para obtener un certificado SSL es instalar el software Certbot en su servidor.
Instalar Certbot y su complemento de Nginx con apt:

sudo apt install certbot python3-certbot-nginx

Paso 2: Confirmar la configuración de Nginx

Certbot debe poder encontrar el bloque server correcto en su configuración de Nginx para que pueda configurar SSL automáticamente. De forma específica, lo hace buscando una directiva server_name que coincida con el dominio para el que está solicitando el certificado.
Si siguió el paso de configuración del bloque server en el tutorial de instalación de Nginx, debería tener un bloque server para su dominio en /etc/nginx/sites-available/ con la directiva server_name configurada de forma apropiada.
Para comprobarlo, abra el archivo de configuración para su dominio usando nano o su editor de texto favorito:

sudo nano /etc/nginx/sites-available/example.com


Encuentre la línea server_name existente. Debería tener el siguiente aspecto:

...
server_name example.com www.example.com;
…

Si esto sucede, salga de su editor y continúe con el paso siguiente.
De lo contrario, actualícelo para que coincida. A continuación, guarde el archivo, cierre el editor y verifique la sintaxis de las modificaciones de la configuración:

sudo nginx -t

Si obtiene un error, vuelva a abrir el archivo del bloque server y compruebe si hay algún error ortográfico o faltan caracteres. Una vez que la sintaxis de su archivo de configuración sea correcta, vuelva a abrir Nginx para cargar la configuración nueva:

sudo systemctl reload nginx

Ahora, Certbot podrá encontrar el bloque server correcto y actualizarlo automáticamente.

Paso 3: Habilitar HTTPS a través del firewall

Si tiene habilitado el firewall de ufw, como se recomienda en las guías de los requisitos previos, deberá ajustar la configuración para permitir el tráfico de HTTPS. Afortunadamente, Nginx registra algunos perfiles con ufw después de la instalación.
Puede ver la configuración actual escribiendo lo siguiente:

  sudo ufw status

Probablemente tendrá este aspecto, lo cual significa que solo se permite el tráfico de HTTP al servidor web:

Output
Status: active

To                         Action      From
--                         ------      ----
OpenSSH                    ALLOW       Anywhere                  
Nginx HTTP                 ALLOW       Anywhere                  
OpenSSH (v6)               ALLOW       Anywhere (v6)             
Nginx HTTP (v6)            ALLOW       Anywhere (v6)
Para permitir de forma adicional el tráfico de HTTPS, habilite el perfil de Nginx Full y elimine el permiso de perfil redundante HTTP de Nginx.

sudo ufw allow 'Nginx Full'
sudo ufw delete allow 'Nginx HTTP'

Paso 4: Obtener un certificado SSL
Certbot ofrece varias alternativas para obtener certificados SSL a través de complementos. El complemento de Nginx se encargará de reconfigurar Nginx y volver a cargar la configuración cuando sea necesario. Para utilizar este complemento, escriba lo siguiente:
sudo certbot --nginx -d example.com -d www.example.com

Esto ejecuta certbot con el complemento --nginx, usando -d para especificar los nombres de dominio para los que queremos que el certificado sea válido.
Si es la primera vez que ejecuta certbot, se le pedirá que ingrese una dirección de correo electrónico y que acepte las condiciones de servicio. Después de esto, certbot se comunicará con el servidor de Let’s Encrypt y realizará una comprobación a fin de verificar que usted controle el dominio para el cual solicite un certificado.
Si la comprobación se realiza correctamente, certbot le preguntará cómo desea configurar sus ajustes de HTTPS:
Output
Please choose whether or not to redirect HTTP traffic to HTTPS, removing HTTP access.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
1: No redirect - Make no further changes to the webserver configuration.
2: Redirect - Make all requests redirect to secure HTTPS access. Choose this for
new sites, or if you're confident your site works on HTTPS. You can undo this
change by editing your web server's configuration.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Select the appropriate number [1-2] then [enter] (press 'c' to cancel):
Paso 5: Verificar la renovación automática de Certbot
Los certificados de Let’s Encrypt son válidos únicamente por noventa días. El propósito de esto es incentivar a los usuarios a automatizar sus procesos de renovación de certificados. El paquete certbot que instalamos se ocupa de esto por nosotros añadiendo un temporizador systemd que se ejecutará dos veces al día y renovará automáticamente cualquier certificado que vaya a vencer en los próximos 30 días.
Puede consultar el estado del temporizador con systemctl:
sudo systemctl status certbot.timer

Output
● certbot.timer - Run certbot twice daily
     Loaded: loaded (/lib/systemd/system/certbot.timer; enabled; vendor preset: enabled)
     Active: active (waiting) since Mon 2020-05-04 20:04:36 UTC; 2 weeks 1 days ago
    Trigger: Thu 2020-05-21 05:22:32 UTC; 9h left
   Triggers: ● certbot.service
