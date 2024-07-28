# helm

Instalacion:

  curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null

  sudo apt-get install apt-transport-https --yes

  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list

  sudo apt-get update
  sudo apt-get install helm

Desintalar app con helm:

  helm uninstall prometheus -n monitoring

Instalar aplicacion a partir de un archivo values.yaml

  helm install --debug --values druid/values.yaml druid druid

Actualizar aplicacion o instalar si no existe:

  helm upgrade --install --values eks/dev-values.yaml keycloak eks --force --wait
