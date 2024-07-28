## Instalar kubectl

Descargar binario:
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

Instalar binario:

  sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

## COMANDOS

Ver version de kubernetes:

  kubectl version --short

Comando para recibir ayuda (help) de kubernetes,
sobre cualquier cosa que necesitamos se usa el comando "describe",
kubectl explain node,servicice etc.. ejemplo:

  kubectl explain node

Elegit editor en kubernetes:

  export KUBE_EDITOR="nano"

## NODES

Ver nodos:

  kubectl get nodes

Ver nodos con mas detalles:

  kubectl get nodes -o wide

Ver nodos en formato yaml:

  kubectl get nodes -o yaml | less

Ver nodo especifico:

  kubectl describe nodes (nombre del nodo)

## NAMESPASES

Crear namespaces:

  kubectl create namespace aznamespace

Ver namespaces existentes:

  kubectl get namespaces

Ver todos los pods, deploy, servicios y replicas del namespace por defecto:

  kubectl get all

Ver todos los pods, deploy, servicios y replicas de todos los namespace:

  kubectl get all --all-namespaces

## DEPLOYTMENTS

Ver todos los deploytment en el namespace default

  kubectl get deploy -o wide
  
Ver todos los deploytment de un namespace en especifico:

  No existe tal comando

Crear deployment:

  kubectl create deployment (asignar nombre) --image (link a imagen de dockerhub)
  
Nota: Los deployment crean pods

Ver un deploytment en especifico

  kubectl get deployment [deployment-name]

Exponer deployment  de forma interna (crear servicio para el pod):

  kubectl expose deploymet (nombre del deployment) --port=8888

Ver deploytment en maquina local:

  kubectl port-forward -n devcluster deployment/grafana 3000

Exponer deployment de forma externa:

  kubectl expose deploymet (nombre del deployment) --type=NodePort --port=80

Ver los logs de un deployment:

  kubectl logs deploy/(nombre del servicio)

Ver las ultimas lineas de logs de un deployment:

  kubectl logs deploy/(nombre del servicio) --tail (numero de lineas)

Ver los logs en tiempo real de un deployment:

  kubectl logs deploy/(nombre del servicio) --tail (numero de lineas) -f

Como escalar un deploytment:

  kubectl scale deploy/(nombre del servicio) --replicas (numero de replicas)

Como reiniciar un deploy

  kubectl rollout restart deploy/prometheus

Eliminar deployment:

  kubectl delete deployment (nombre del deployment)


## PODS

Ver todos los pods del namespace por defecto:

  kubectl get pods

Ver todos los pods de todos los namespasces:

  kubectl get pods --all-namespaces

Ver todos los pods de un namespasces en especifico:

  kubectl get pod -n kube-system  

Ver un pod en especifico:

  kubectl describe pod (nombre del pod)

Verificar replicas de pods:

  kubectl get pods -o wide
  kubectl get po --all-namespaces -o wide

Eliminar un pod:

  kubectl delete pod (nombre del pod)

Nota: si este pod fue escalado con un replica set o con un archivo de configuracion, automaticamente kubernetes volvera a crearlo

Ingresar dentro de un contenedor

  kubectl exec -ti <your-pod-name>  -n <your-namespace>  -- /bin/sh

## SERVICES

Ver todos los servicios del namespace por defecto:

  kubectl get services

Ver todos los servicios de un namespace en especifico:

  kubectl get services -n kube-system

Eliminar servicio:

  kubectl delete services (service name)

Usar archivo de configuracion ya definido para nuestro clouster:

  kubectl --congig (nombre del archivo)
  kubectl --congig mi_config
  
Nota: el archivo config debe de estar en la carpeta .kube

Crear archivo de configuracion manualmente:

  kubectl --server --user

Ver archivos secretos de kubernetes:

  kubectl get secrets -n kube-public

Generar archivo con esquema de configuracion para un pod,
esto es para reutilizarlo en donde se desee

  kubectl run --dry-run -o yaml pingpong --image alpine ping 1.1.1.1

Borrar todo en kubernete:

  kubectl delete all --all
  kubectl delete all --all -n monitoring

Usar archivos yaml para la creacion de deploytment, servicios etc..

  kubectl apply -f my_file.yaml

Revertir instalaciones hechas con apply:

  kubectl delete -f <filename>



## INGRESS NGINX

Ver reglas ingres

  kubectl get ing -n devluster

## MONITORING

Ver consumo de los nodos

   kubectl top no

Ver consumo de los pods

  kubectl top po --all-namespaces

General archivos yaml a partir de deployment y services instalados

  kubectl get deployment myreleasename-helloworld -n default -o yaml > deployment.yaml
  kubectl get service hellworldexample-helloworld -n default -o yaml > service.yaml
  kubectl get daemonset hellworldexample-helloworld -n default -o yaml > daemonset.yaml
  kubectl get statefulset hellworldexample-helloworld -n default -o yaml > statefulset.yaml

Asignar label a nodo:

  kubectl label nodes <node-name> <label-key>=<label-value>
  
Ejemplo:

  kubectl label nodes v15-dev-worker-03 disktype=worker3

Ver labels asignados a los nodes

  kubectl get nodes --show-labels

Ver todos los pod con mas detalles:

  kubectl get po --all-namespaces -o wide
  
Filtrar pod por nodos:

  kubectl get po --all-namespaces -o wide --field-selector spec.nodeName=kworker1

Generar archivos yaml a partir de un deploy existente:

  kubectl get service hellworldexample-helloworld -n default -o yaml > service.yaml
  kubectl get deployment myreleasename-helloworld -n default -o yaml > deployment.yaml

Ver configmaps existentes en un despliegue:

  kubectl get configmaps

Ver configmaps en especidico:

  kubectl get configmaps usermanagement-configmap -o yaml
  kubectl get pods --field-selector=status.phase=Running

Instalar curl dentro de un pod:

  apk add --no-cache curl
  
Cifrar en base 64:

  echo -n '1f2d1e2e67df' | base64



