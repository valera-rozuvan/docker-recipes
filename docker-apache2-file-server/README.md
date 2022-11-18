# docker-apache2-file-server

Run an Apache2 static file server via Docker. Key features:

- specify port at runtime
- map random virtual path to host folder

## Build

```
sudo docker build -t file-server .
```

## Run

Decide on the port number you want `apache2` to run on. For this example, port `7154` was chosen. Please modify below commands accordingly, if you choose a different port number.

```
sudo docker run \
  --name file-server-7154 \
  -v /absolute/host/path/to/data/folder:/var/www/html/RANDOM_STRING_FT67VGF667GH \
  -e APACHE_LISTEN_PORT='7154' \
  -p 7154:7154 \
  --expose 7154 \
  --memory="400m" \
  --memory-swap="1g" \
  -d \
  file-server
```

You can now go to http://localhost:7154/RANDOM_STRING_FT67VGF667GH and see your files. If you can open port 7154 on your host system to the world, and your host has an external IP, you will be able to also access files via your IP.

## Check container stats

```
sudo docker ps -q | xargs sudo docker stats --no-stream
```

## Check container volume mounts

```
$ sudo docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                    NAMES
754a56c8facc        file-server         "/usr/sbin/apache2 -…"   22 hours ago        Up 22 hours         0.0.0.0:7154->7154/tcp   file-server-7154

$ sudo docker inspect -f "{{ .Mounts }}" 754a56c8facc
[{bind  /absolute/host/path/to/data/folder /var/www/html/RANDOM_STRING_FT67VGF667GH   true rprivate}]
```

## Stop container

```
sudo docker stop file-server-7154
sudo docker rm file-server-7154
```

## cgroup config

If you get some warning about `--memory-swap` flag, then you need to update `/etc/default/grub` and set:

```
GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1"
```

For this to propagate to the kernel, run `update-grub && reboot`.

## Enjoy ;)
