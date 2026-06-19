# PodQuadlets

## Usage

Use [podman quadlet install](https://docs.podman.io/en/v5.8.2/markdown/podman-quadlet-install.1.html) on the application folder you wish to install.  This should create systemd user services for the required containers and pods.

Refer to the linked documentation to aquire more relavent knowledge.


- If the application only consists of a `.container` file then you can start `<service>` directly

- If the application consists of a `.pod` file then you must start `<service>-pod` which will start all related containers

Here `<service>` refers to the container or pod name
