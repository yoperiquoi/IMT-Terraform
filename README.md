# IMT-Terraform (Yoann PERIQUOI & Théo DILLENSEGER)

> :warning: **ALL THE CODE FOR THE TP IS STORED UNDER *TP* REPOSITORY**:


# Project Prerequisites

To ensure the proper functioning of the project, make sure you have the following prerequisites in place:

### Directory Structure

1. go the directory named `tp`.

    ```bash
    cd tp
    ```

2. Clone the "example-voting-app" project into the `tp` directory.

    ```bash
    git clone https://github.com/dockersamples/example-voting-app.git 
    ```

### Google Cloud Platform

Don't forget to copy your gcp credentials into ``tp\gcp\providers.tf`` and ``tp\openstack\providers.tf``  for google provider.

## Docker

To run the docker terraform files, run the following commands:

```bash
    cd tp/docker
    tf init
    tf plan
    tf apply
```

If it is working, then go to [vote front-end](http://localhost:4999) and [result front-end](http://localhost:5001)

## GCP

To run the gcp terraform files, run the following commands:

```bash
    cd tp/gcp
    tf init
    tf plan
    tf apply
```

If it is working, then go to [GCP ingress](https://console.cloud.google.com/kubernetes/ingresses) to try.

## OpenStack

To run the openstack terraform files, run the following commands:

```bash
    cd tp/openstack
    tf init
    tf plan
    tf apply
```

The apply will not retrieve any error but there is one. We have created the Redis Virtual machine on openstack but it is not link with GCP.
We should update the images on GCP with the openstack image (with good password and so on).

The GitHub Action has been created to do a terraform plan on each push on every branches and the terraform apply is executed only when the push is on the main branch.
To make this working, our tfstate has been pushed to a bucket on GCP to keep track remotely of the state of the GCP.
