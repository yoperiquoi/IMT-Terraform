# IMT-Terraform (Yoann PERIQUOI & Théo DILLENSEGER)

> :warning: **ALL THE CODE FOR THE TP IS STORE UNDER *TP* REPOSITORY**:


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

If it is working, then go the  to reach [vote front-end](http://localhost:4999) and [result front-end](http://localhost:5001)

## GCP

To run the gcp terraform files, run the following commands:

```bash
    cd tp/gcp
    tf init
    tf plan
    tf apply
```

If it is working, then go the  to [GCP ingress](https://console.cloud.google.com/kubernetes/ingresses) to try.

## OpenStack

To run the openstack terraform files, run the following commands:

```bash
    cd tp/openstack
    tf init
    tf plan
    tf apply
```

