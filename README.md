# PodQuadlets

## Usage

Use [podman quadlet install](https://docs.podman.io/en/v5.8.2/markdown/podman-quadlet-install.1.html) on the application folder you wish to install.  This should create systemd user services for the required containers and pods.

Refer to the linked documentation to aquire more relavent knowledge.


- If the application only consists of a `.container` file then you can start `<service>` directly

- If the application consists of a `.pod` file then you must start `<service>-pod` which will start all related containers

Here `<service>` refers to the container or pod name

## Configuration

For a given application (`foo`) there is usually a default env file with the `env.defaults` extension (`foo.env.defaults`).

It is possible to override the environment variable in the `.env.defaults` by simply creating an additional env file with just the `.env` extension (`foo.env`) in the `$XDG_CONFIG_HOME/containers/systemd/` directory.

For more complex modification of the configuration, drop-in directories should be used. Please refer to the documentation of [Podman Systemd Unit](https://www.freedesktop.org/software/systemd/man/latest/systemd.unit.html) and [Systemd Unit](https://www.freedesktop.org/software/systemd/man/latest/systemd.unit.html) to learn more about Drop-ins.

