sinewave-new-deploy
===
This repo host scripts for deploy sinewave new


### Prerequisites
- terraform   `>= v0.12.6`


Provision Steps:
---

#### Authenticate to AWS

Export AWS credential or profile to environment variable:
```sh
export AWS_ACCESS_KEY_ID=XXXX
export AWS_SECERT_ACCESS_KEY=XXXXX
export AWS_REGION=XXXXX
 
#or 

export AWS_PROFILE=<your-profile-name>
```

#### Enable remote backends

```sh
cd  environments/dev/1-state

# install all modules(only needed at the first run)
terraform init
# examine changes to be applied
terraform plan -var-file="../terraform.tfvars"
# apply changes
terraform apply -var-file="../terraform.tfvars"
```

#### Provision Infrastructures
components should be provisioned in the following order
- image-repo
- database
- app

Note: you may not need to provision image-repo and database frequently, the normal application deploy should just provision app component with environment variables in `environments/<env>/terraform.tfvars`

```sh
cd  environments/dev/<component>

# install all modules(only needed at the first run)
terraform init
# examine changes to be applied
terraform plan -var-file="../terraform.tfvars"
# apply changes
terraform apply -var-file="../terraform.tfvars"
```


### How to ssh to sinewave new ec2 instances?
1. Add your ssh private key to ssh agent
`ssh-add <path-to-your-private-key>`
2. ssh to bastion with agent key forwarding enabled
`ssh ubuntu@<bastion-ip> -A`
3. find sinewave new ec2 instance IP and ssh to it?
`ssh ec2-user@<sinewave-new-host-ip>`

### How to launch rails console on sinewave new?
1. Follow the previsou steps to ssh to sinewave new host
2. Find the sinewave-new container 
```
docker ps
```
3. Attach to the running container and launch rails console
```
docker exec -it <container_id> /app/bin/rails console
```
