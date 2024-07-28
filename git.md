# Git

Instalación:

Nota: Previamente se debe de tener una cuenta en github.

Instalar git con el siguiente comando:

  sudo apt-get install git

Configurar el usuario y contraseñas con los siguientes comandos (opcional):

  git config --global user.name "YOUR NAME"

  git config --global user.email "YOUR EMAIL ADDRESS"


Verificar la rama actual donde se esta trabajando:

  git branch

Crear rama:

  git branch vm_addons_proveeduria

Nota: se creara una rama copia de la rama en donde se esta situado.


Cambiarse de rama:

  git checkout vm_addons_proveeduria

Crear rama y cambiarse a la rama creada:

  git checkout -b (nombre deseado)
  git checkout -b vm_addons_proveeduria

Agregar cambios a stash:

  git add .

Crear commit:

  git commit -m "se agrega archivo de texto para realizar pruebas"

Ahora para subir el archivo a github nos cambiamos a la rama master:

  git checkout master

Ejecutamos un git marge para fucionar la rama de prueba con la master:

  git merge pruebas    (o el nombre de la rama)

Y luego subimos los cambios con:

  git push origin master

Y nos volvemos a pasar a la rama de prueba para continuar trabajando

  git ckeckout pruebas

Eliminar todo el repositorio local ejecutas rm -rf .git

Trabajar con ramas remotas

  git fetch && git checkout (rama)
  git fetch && git checkout task

Actualizarla

  git pull (repositorio remoto) (rama remota)
  git pull ATX task

Eliminar ramas

  git branch -D nombre de la rama

Eliminar ramas remotas

  git push origin --delete nombredelarama

Resetear merge cuando algo este mal

  git reset --merge

Para crear una rama remota

  git push -u origin <nombre_nueva_rama>


Eliminar repositorios remotos

  git remote rm <remote-name>

Agregar repositorios remotos

  git remote add <remote-name> http//myrepo

Para eliminar ultimo commit:

  git reset --hard HEAD~1

Descargar cambios de las ramas sin hacer merge

  git fetch origin

Actualizar rama con la master

  git rebase origin/master

Ver archivos en conflictos:

  git diff --name-only --diff-filter=U

Guardar cambios temporales con stash

El comando stash sirve para guardar cambios temporalmente para poder cambiar a otra rama

  git stash
  git stash list

Recuperar ultimo stash

  git stash apply

Recuperar especifico stash

  git stash apply stash@{2}

Revertir merge:

  git merge --abort

Revertir commit sin haber hecho push:

  git reset --hard HEAD~1

Revertir todos los archivos agregados con git add:

  git checkout .

Como realizar un release:

  git checkout -b release/0.1.11

Modificar CHANGELOG.md

  git add .
  git commit -m "release/0.1.11"
  git push origin release/0.1.11
  git tag v0.2.14
  git push --tags 

Cerrar release

  git checkout master
  git merge release/0.1.14 --no-ff
  git tag v0.2.14
  git checkout develop
  git merge release/0.1.14 --no-ff
  git branch -d release/0.1.14

Como realizar un release con git flow:

  git flow release finish 0.2.14
  * Git Flow

Desde la rama decelop

  git flow release start 0.2.16

Modificar CHANGELOG.md

  git add .
  git commit -m "release/0.2.17"
  git flow release publish 0.2.16
  git tag v0.2.16
  git flow release finish 0.2.16
  git push --tags
  git push origin develop
  git checkout master
  git push origin master
  git checkout develop













