# Hackathon AWS by Cloud Treinamentos

Desenvolver uma infraestrutura como código, usando o Terraform para disponibilizar publicamente uma aplicação .net em nuvem da AWS.

## 🚀 Começando

Essas instruções o ajudarão a implementar a aplicação criada para desafio usando o Terraform.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.9 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.19 |
| <a name="git"></a> [git](#requirement\_git) | >= 2.34.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.19 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_network"></a> [network](#module\network) | ./modules/network | n/a |
| <a name="module_iam"></a> [iam](#module\iam) | ./modules/iam | n/a |
| <a name="module_s3"></a> [s3](#module\s3) | ./modules/s3 | n/a |
| <a name="module_rds"></a> [rds](#module\rds) | ./modules/rds | n/a |
| <a name="module_sm"></a> [sm](#module\sm) | ./modules/sm | n/a |
| <a name="module_alb"></a> [alb](#module\alb) | ./modules/alb | n/a |
| <a name="module_ecr"></a> [ecr](#module\ecr) | ./modules/ecr | n/a |
| <a name="module_ecs"></a> [ecs](#module\ecs) | ./modules/ecs | n/a |
| <a name="module_as"></a>  [as](#module\as)   | ./modules/as  | n/a |

## Variables Inputs

| Name | Type | Default | Required |
|------|------|---------|:--------:|
| <a name="owner"></a> owner | `string` | `null` | yes |
| <a name="aws_region"></a> aws_region | `string` | `us-east-1` | yes |
| <a name="project_name"></a> project_name | `string` | `null` | yes |
| <a name="domain_name"></a> domain_name | `string` | `null` | yes |
| <a name="terraform"></a> terraform | `bolean` | `true` | yes |
| <a name="environment"></a> environment | `string` | `dev` | yes |

### 🔧 Instalação Projeto

```
Instalação do Terraform:
https://developer.hashicorp.com/terraform/downloads

Instalação Git:
https://git-scm.com/

Configuração Git:
git config --global user.name "Informe o seu nome"
git config --global user.email "Informe o seu e-mail"
```

#### ***Importante!!!***

No projeto é utilizado o S3 como backend para armazenar o arquivo terraform.tfstate, por isso será necessário editar o arquivo provider.tf informando o nome do seu bucket, que deverá ser previamente criado na AWS.

Para utilização do certificado SSL e o domínio personalizado para o ALB, é necessário ser criado a zona de hospedagem no Route 53 previamente e criado o certificado.

Clonar o repositório
```
Para clonar o repositório execute:
git clone https://github.com/nicolasmatos/hackathonAWSUpperTurismo.git
```

Em seguida fazer a inicialização do Terraform:

```
terraform init
```

## ⚙️ Criando a infraestrutura na Cloud da AWS

Importante!!!
Certifique-se de estar no diretório onde o repositório foi clonado, etapa acima e acessado a pasta iac.

Execute o comando:
```
terraform apply
```

## 📦 Implantação

No momento em que o comando for executado, todos os recursos utilizados para criação da infra-estrutura serão listados.

**Uma mensagem será exibida em tela aguardando a confirmação.**

Para execução e criação da infra-estrutura é necessária a confirmação digitando **"y"** (yes).

## 🗂️ Diagrama da solução

![Serviços AWS utilizados!](/diagram/diagram.png "Serviços AWS utilizados")

## 🛠️ Ferramentas utilizadas

* [AWS](https://aws.amazon.com/pt/console/) - Cloud Provider
* [Draw.io](https://draw.io/) - Diagrama
* [Git](https://git-scm.com/downloads) - Controle de Versão
* [Github](https://github.com/) - Repositório Remoto
* [Terraform](https://developer.hashicorp.com/terraform/downloads) - Infraestrutura como código
