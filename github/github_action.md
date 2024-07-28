Instrucciones

En la raiz del proyecto, debes crear una carpeta oculta llamada .github/workflows
y alli dentro colocamos los action que usaremos en formato yaml ejemplo:

  .github/workflows/my_action.yaml

  
////// ejemplo //////


name: Maven Package 

on:
  push:
    branches: [action_test] 
    tags:
      - '*'
jobs:
  build: 
    runs-on: ubuntu-latest 
    permissions:
      contents: read
      packages: write
   
    steps:
    - uses: actions/checkout@v2 
    - name: Set up JDK 8 
      uses: actions/setup-java@v3
      with: 
        java-version: '8'
        distribution: 'adopt'
        server-id: github
        settings-path: ${{ github.workspace }}
    - name: Execute mvn
      run: mvn package -DskipTests
    - name: Temporarily save jar artifact
      uses: actions/upload-artifact@v2
      with:
        name: jar-artifact
        path: ${{ github.workspace }}/target/*.jar
        retention-days: 1

  publish:
    runs-on: ubuntu-latest
    needs: build 
    steps:
    - uses: actions/checkout@v2
    - uses: actions/download-artifact@v1
      with:
          name: jar-artifact
          path: target/
    - name: Get tag
      id: tag
      uses: dawidd6/action-get-tag@v1
    - name: Docker build
      run: |
        docker build -t aryadigital/geofolia-prc:${{steps.tag.outputs.tag}} .
    - name: Login to DockerHub
      uses: docker/login-action@v1
      with:
        username: ${{ secrets.DOCKER_USERNAME }}
        password: ${{ secrets.DOCKER_PASSWORD }}
    - name: Docker push
      run: |
        docker push aryadigital/geofolia-prc:${{steps.tag.outputs.tag}}
  deploy-to-cluster:
    name: deploy to cluster
    runs-on: ubuntu-latest
    needs: publish
    steps:
    - name: Get tag
      id: tag
      uses: dawidd6/action-get-tag@v1
    - name: deploy to cluster
      uses: Consensys/kubernetes-action@master
      env:
        KUBE_CONFIG_DATA: ${{ secrets.KUBE_CONFIG_DATA }}
        KUBECTL_VERSION: "1.20"
      with:
        args: set image deploy -n dev geofolia-prc geofolia-prc=aryadigital/geofolia-prc:${{steps.tag.outputs.tag}}
