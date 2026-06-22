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

### Linkace

> [!WARNING]
> I noticed [Mixed Content](https://developer.mozilla.org/en-US/docs/Web/Security/Defenses/Mixed_content) errors in the browser console that breaks the update checking functionality.
> 
> After endless amounts of tinkering I discovered that in my caddy configuration changing `reverse_proxy localhost:8080` to `reverse_proxy 0.0.0.0:8080` fixes this issue.
> 
> I have not tested extensively but I think this issue does not occur if `podman-compose` is used, so perhaps it could be some kind of setup flaw.
>
>  Either way, I genuinely have no idea why this is happening.

The `linkace-app` container will not start without the `linkace.env` file. This is because the environment variable `APP_KEY` needs to be set manually.

The following command should set the `APP_KEY` environment variable in the `linkace.env` file.
```bash
echo "APP_KEY=$(podman run --rm linkace/linkace php artisan key:generate --show)" > "$XDG_CONFIG_HOME/containers/systemd/linkace.env"
```

You may edit the `linkace.env` to set further overrides, for example:

`$XDG_CONFIG_HOME/containers/systemd/linkace.env`
```
APP_KEY=base64:WrA2mmwJ+B7IQ4Jf0o0HDk5L0Wq9cWaBWJTAzw0c6Ag=

APP_URL=https://link.example.com
DB_PASSWORD=tr0ub4dor&3
```

### Joplin

You can change the website URL by overriding the `APP_BASE_URL` environment variable, for example:

`$XDG_CONFIG_HOME/containers/systemd/joplin.env`
```
APP_BASE_URL=https://joplin.example.com
```

### Qbittorrent

Custom bind mounts can be defined in drop-in files, for example:

`$XDG_CONFIG_HOME/containers/systemd/qbittorrent.container.d/volume.conf`
```
[Container]
Volume=/home/JackSparrow/downloads:/downloads:Z
```

### Stirling

Stirling pdf can be configured using environment variables, but i have found its behaviour to be inconsistent. There is actually so much more thats inconsistent, but i cannot find an alternative other than BentoPDF, which is slow for complex operations.

I suggest configuring this application using its `settings.yml` file. You could setup a bind mount or modify the file through any other means. I personally make use the `podman cp` command to copy the file after which i use the same command to copy the modified file back to the volume.

```bash
podman cp stirling-pdf:/configs/settings.yml .

# ... After modifying the yml file ...
podman cp ./settings.yml stirling-pdf:/configs/settings.yml
```