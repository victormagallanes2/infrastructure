Instalacion usando helm

  kubectl create ns monitoring

  helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

  helm install prometheus prometheus-community/kube-prometheus-stack -n monitoring

Instalacion de loki

  helm repo add loki https://grafana.github.io/loki/charts

  helm repo update

  helm upgrade --install loki --namespace=monitoring loki/loki-stack
  
Credenciales grafana

  username: admin
  password: prom-operator
