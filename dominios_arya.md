# Gestion de dominios en Arya

  Los dominios se crean en sared pero se gestionan en aws a traves de Dns.


Gestion de dominio desde aws:


Al crarse el dominio en sared se almacena el registro en unos servidores dns por defecto propios de sared,
esto debe cambiarse para que sean gestionados desde los servidores de aws para ellos seguimos los siguientes
pasos:

  1. Creamos una zona de alojamiento en route 53 con el dominio que se desea gestionar, este debe de tener 2 registros, una para el dominion y otro para los subdominios ejemplo:

  midominio.com y *midominio.com

  2. Al momento de crear la zona se nos dara unos servidores dns, estos se deben de registrar en el los
     registros Dns de sared en donde se registro el dominio y se debe sustituir por los que vienen por defecto, de esta forma aws comprueba que el dominio te pertenece.


Asignacion de dominio en una aplicacion desplegada en kubernetes:

  1. Ingresamos route 53 zonas de alojamiento y clickeamos el dominio principal que vamos a usar.

  2. A ese dominio principal le creamos un subdominio haciendo click en crear registro.
  
  3. Asignamos el dominio, tipo de dominio generalmente tipo A, en el apartado valor activamos el alias
     y seleccionamos Alias del classic load balancer y el aplicaciones, seleccionamos la region y la url
     que usaremos y damos click en guardar.

Asignacion de dominio en una aplicacion desplegada en cloudfront:

  1. Ingresar a cloud front y seleccionar el registro a modificar, 
  
  2. En la parte de la edicion colocar como dominio alternativo el subdominio que se desea asignar junto
     al certificado que se decea usar.
  
  3. Copias la Distribution domain name que da cloudfront para que accedas a la aplicacion y a
     continuacion ingresas a route 53.
  
  3. Ingresamos route 53 zonas de alojamiento y clickeamos el dominio principal que vamos a usar.

  4. A ese dominio principal le creamos un subdominio haciendo click en crear registro.
  
  5. Asignamos el dominio, tipo de dominio generalmente tipo A, en el apartado valor activamos el alias
     y seleccionamos Alias de la distribucion de cloudfront, seleccionamos la region y pegamos el
     Distribution domain name de cloudfront y damos click en guardar.
  

