# Terraform

Instalacion:

Agregar llave:

  wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

Agregar repositorio:

  echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

Update and install:

  sudo apt update && sudo apt install terraform

Create and enter the folder where the terraform files will be created and executed:

  mkdir terraform_aws
  cd terrform_aws
    
### Conectar con Aws

Terraform it uses files with a .tf extension and the language used is HCL (HashiCorp Configuration Language). To connect with the different providers terraform uses plugins called provider which is declared in a terraform file:

    nano provider.tf

/provider.rf

    terraform {
      required_providers {
        aws = {
          source  = "hashicorp/aws"
          version = "~> 4.0"
        }
      }
    }

    provider "aws" {}
 
The line that says provider will receive the aws account credentials through environment variables.



