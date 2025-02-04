# Basic Kubernetes Secrets

This folder contains all the necessary code to deploy an [AWS EKS cluster](https://aws.amazon.com/eks/) (Kubernetes on AWS) via terraform, then deploy a simple application that uses basic Kubernetes Secrets.

## How to deploy

1. Make sure you have the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) installed with valid credentials, and that [Docker](https://docs.docker.com/desktop/), [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) and [Helm](https://helm.sh/docs/intro/install/) installed.

2. Deploy the EKS cluster (up to 30 min)

```sh
cd infrastructure
terraform apply
```

3. Verify the cluster is reachable

Make sure that you have valid credentials stored locally (for instance via Granted), then configure the cluster locally.

```sh
aws eks update-kubeconfig --region eu-central-1 --name eks-cluster
```

Then verify that you can connect to it:

```sh
kubectl get pods
```

4. Deploy the application Pod

```sh
cd ..
helm install webapp helm/webapp/ -set secrets.MY_SECRET=123456a
```

5. Check that the pod is reachable by running this command and pasting the EXTERNAL-IP in a browser.

```sh
kubectl get svc webapp
```