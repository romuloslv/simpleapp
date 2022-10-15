# Installing simpleapp with Terraform/Helm on GCP

The idea of ​​this hands on is to install a python application on a K8S cluster using the technologies most consumed by the market at the time of construction.

## Stack

Terraform, Helm, Kubernetes, Grafana, Prometheus, Kibana, Elasticsearch, Dapr, Jaeger, Docker, Fluentd, Python, Ingress, Certmanager

## Features
_Every feature will be deployed via terraform_

- Install GKE (Google Kubernetes Enginee) cluster 
- It will contain 1 node pool with 3 nodes **southamerica-east1-a**
- It contains a helm provider that will be responsible to install the apps in cluster
- A python application to test the monitoring/logging part
- Two python applications(backend/frontend) to test the observability part

## Requirements
Before starting you should have the following commands installed:

- [helm](https://helm.sh/docs/intro/install/#helm)
- [terraform](https://www.terraform.io/downloads)
- [gcloud-auth](https://cloud.google.com/blog/products/containers-kubernetes/kubectl-auth-changes-in-gke)
- [gcloud](https://cloud.google.com/sdk/docs/install)

## Let's play

First, you have to authenticate into Google Cloud console, to so run the following command,

`gcloud auth login`

Now login with application-default

`gcloud auth application-default login`

Once you are logged it, you should export 3 variables you are going to use

`export KUBE_CONFIG_PATH=~/.kube/config USE_GKE_GCLOUD_AUTH_PLUGIN=True GOOGLE_PROJECT=<YOUR-PROJECT-NAME>`

Now, you can run

`terraform init && terraform validate && terraform fmt`

It will load the providers and configuration. Right after that, you should run

`terraform plan -var user="<USER-NAME>" -var kubernetes_name="<KUBERNETES-NAME>"`

It will show you everything that will be created by terraform, take a moment to check this output.
Once you are ready, you just need to run:

`terraform apply -auto-approve -var user="<USER-NAME>" -var kubernetes_name="<KUBERNETES-NAME>"`

It will apply your changes in sequence.
Once everything was applied, you will get an output similar to this,

![](https://raw.githubusercontent.com/romuloslv/simpleapp/main/1mgs/img11.png)

Follow this example to connect to the newly created cluster

`gcloud container clusters get-credentials <KUBERNETES-NAME> --region europe-west1 --project <YOUR-PROJECT-NAME>`

Once you `port-foward` your services, you can easily access it on your browser via localhost.

```
$ kubectl get svc -n lab-dashboard | awk '{print $4}'

$ kubectl get svc -n lab-app | awk '{print $4}' | head -n2

$ kubectl port-forward $(kubectl get pods -l=app.kubernetes.io/instance="monitor" -o name -n lab-monitoring) 3000 -n lab-monitoring

$ kubectl port-forward $(kubectl get pods -l=app="prometheus" -o name -n lab-monitoring | tail -n1) 9090 -n lab-monitoring

$ kubectl port-forward $(kubectl get pods -l=app="elasticsearch-master" -o name -n lab-logging) 9200 -n lab-logging

$ kubectl port-forward $(kubectl get pods -l=app="kibana" -o name -n lab-logging) 5601 -n lab-logging

$ kubectl port-forward $(kubectl get pods -l=app="jaeger" -o name -n lab-observability) 16686 -n lab-observability

$ kubectl port-forward $(kubectl get pods -l=app="frontend" -o name -n lab-observability) 8000 -n lab-observability
```

## Wrapping up
Now, to clean up everything you just need to run

`terraform destroy -auto-approve -var user="<USER-NAME>" -var kubernetes_name="<KUBERNETES-NAME>"`

That's all folks!
