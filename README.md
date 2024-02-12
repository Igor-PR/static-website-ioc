# static-website-ioc
Repo dedicated to creating a static website using Infrastructure as Code

## Initializing terraform

The IoC available here is capable of being deployed to multiple AWS accounts simultaneously. 

In order to deploy to deploy to a specific AWS account, set the default **credentials** profile in `.aws/credentials` with the proper access keys or run the following commands to use a specific profile

```
export AWS_ACCESS_KEY_ID=$(aws configure get <my_profile>.aws_access_key_id)
export AWS_SECRET_ACCESS_KEY=$(aws configure get <my_profile>.aws_secret_access_key)
```

Once that has been configured, make sure you have a valid bucket for the backend and run 

```
terraform init
```

## Deploying Components

Some components, such as the S3 bucket name and DNS, are configured through terraform variables. In order to be able to deploy the infrastructure, create a `.tfvars` file similar to **deployment.tfvars** with the values you desire.

Once that has been set up, simply run the following:

```
terraform plan --var-file="deployment.tfvars"
```

If everything looks good, go ahead and deploy with

```
terraform apply --var-file="deployment.tfvars"
```
