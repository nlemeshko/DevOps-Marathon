# DevOps Marathon

[![docker](https://github.com/nlemeshko/DevOps-Marathon/actions/workflows/docker.yml/badge.svg)](https://github.com/nlemeshko/DevOps-Marathon/actions/workflows/docker.yml)
[![Terraform](https://github.com/nlemeshko/DevOps-Marathon/actions/workflows/terraform.yml/badge.svg)](https://github.com/nlemeshko/DevOps-Marathon/actions/workflows/terraform.yml)
[![Ansible](https://github.com/nlemeshko/DevOps-Marathon/actions/workflows/ansible.yml/badge.svg)](https://github.com/nlemeshko/DevOps-Marathon/actions/workflows/ansible.yml)

# Info:

Project for DevOps Marathon by [Anton Pavlenko](https://www.youtube.com/channel/UC_hvS-IJ_SY04Op14v3l4Lg)

Creates simple GO application and Telegram bot which communicate using JSON and Basic Auth
You can send to Bot /command [example] and and this will execute on the remote server

# Requements

- AWS acoount with Free Tier and high
- Account in DockerHub
- Account in app.terraform.io
- Created bot in telegram by BotFather


# Secrets

 | Secrets | Discription | Example |
| ------ | ------ | ------ |
| **ADMINCHAT** | *Your id in Telegram* | 315660491
| **BOTTOKEN** | *Token youe Bot from BotFather* | asdasd3ds:asdsad3773dhd37d37d
| **DB_NAME** | *Name of your future Database* | db
| **DB_PASSWORD** | *User password of future Database* | qwerty123
| **DB_USERNAME** | *User username of future Database* | admin
| **DOCKERHUB_USERNAME** | *Username of your Dockerhub account* | docker
| **DOCKERHUB_TOKEN** | *Password of your Dockerhub account* | docker
| **USERNAME** | *Username for Basic Auth* | admin
| **PASSWORD** | *Password for Basic Auth* | admin
| **SSH_PRIVATE_KEY** | *Private Key from Key pair in AWS EC2* | -----BEGIN RSA PRIVATE KEY...
| **TF_API_TOKEN** | *Token to communicate with app.terraform.io* | xcv7xcv77xcv77xxcv
| **DOCKERREPO** | *Repo of your DockerHub* | mdsn/devops-marathon



# AWS:

- **EC2**
- **VPC** 
- **Lambda**
- **API Gateway**
- **RDS**

# Usage:

- *Fork project and setup all variables and dont forget set app.terraform.io*
- *Push*
- *Wait*
- ...
- ..
- *Profit*


### [Nicky Lemeshko](https://mdsn.tk) (c) 2021
