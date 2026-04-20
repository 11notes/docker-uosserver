![banner](https://raw.githubusercontent.com/11notes/static/refs/heads/master/img/banner/README.png)

# UOSSERVER
![size](https://img.shields.io/badge/image_size-2GB-green?color=%2338ad2d)![5px](https://raw.githubusercontent.com/11notes/static/refs/heads/master/img/markdown/transparent5x2px.png)![pulls](https://img.shields.io/docker/pulls/11notes/uosserver?color=2b75d6)![5px](https://raw.githubusercontent.com/11notes/static/refs/heads/master/img/markdown/transparent5x2px.png)[<img src="https://img.shields.io/github/issues/11notes/docker-uosserver?color=7842f5">](https://github.com/11notes/docker-uosserver/issues)![5px](https://raw.githubusercontent.com/11notes/static/refs/heads/master/img/markdown/transparent5x2px.png)![swiss_made](https://img.shields.io/badge/Swiss_Made-FFFFFF?labelColor=FF0000&logo=data:image/svg%2bxml;base64,PHN2ZyB2ZXJzaW9uPSIxIiB3aWR0aD0iNTEyIiBoZWlnaHQ9IjUxMiIgdmlld0JveD0iMCAwIDMyIDMyIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPgogIDxyZWN0IHdpZHRoPSIzMiIgaGVpZ2h0PSIzMiIgZmlsbD0idHJhbnNwYXJlbnQiLz4KICA8cGF0aCBkPSJtMTMgNmg2djdoN3Y2aC03djdoLTZ2LTdoLTd2LTZoN3oiIGZpbGw9IiNmZmYiLz4KPC9zdmc+)

run Unifi OS server as a container

# INTRODUCTION 📢

Self‑hosted software package that delivers UniFi Network, and soon additional applications in the UniFi ecosystem, from a single install.

# CAUTION ⚠️
> [!CAUTION]
>To run this image safely, since it needs access to certain resources of your host, run it via ```sysbox``` runtime and not the default Docker runtime if you are **not using rootless runtimes**!
>This image is in active development, there could be potential major changes on how this image handles volumes, data, etc!

# SYNOPSIS 📖
**What can I do with this?** This image will provide you a rock solid Unifi OS server image. This image breaks (currently) all container philosophies by running multiple containers inside this image that are managed by the Unifi OS Server. This means updates to the apps inside the image are handled by the Unifi OS Server, not the image. Only the Unifi OS Server image itself is handled by this image. Consider running a VM instead of a container for this.

# UNIQUE VALUE PROPOSITION 💶
**Why should I run this image and not the other image(s) that already exist?** Good question! Because ...

> [!IMPORTANT]
>* ... this image is auto updated to the latest version via CI/CD
>* ... this image has a health check
>* ... this image is created via a secure and pinned CI/CD process

If you value security, simplicity and optimizations to the extreme, then this image might be for you.

# VOLUMES 📁
* **/sys/fs/cgroup** - Directory on your host to access cgroups
* **/persistent** - Directory of package manager
* **/data** - Directory of all application data
* **/srv** - Directory of service specific data
* **/var/lib/unifi** - Directory of Unifi Network Controller data
* **/var/lib/mongodb** - Directory of mongodb
* **/etc/rabbitmq/ssl** - Directory of self-signed SSL certificates for RabbitMQ

# COMPOSE ✂️
```yaml
name: "unifi"
services:
  os-server:
    runtime: sysbox-runc
    cpus: "8.0"
    mem_reservation: "4G"
    mem_limit: "8G"
    image: "11notes/uosserver:5.0.6"
    cap_add:
      - NET_RAW
      - NET_ADMIN
    cgroup: host
    environment:
      TZ: "Europe/Zurich"
      UOS_SYSTEM_IP: "${IP}"
    volumes:
      - "/sys/fs/cgroup:/sys/fs/cgroup:rw"
      - "os-server.var:/persistent"
      - "os-server.log:/var/log"
      - "os-server.data:/data"
      - "os-server.srv:/srv"
      - "os-server.lib:/var/lib/unifi"
      - "os-server.db:/var/lib/mongodb"
      - "os-server.rabbitmq.ssl:/etc/rabbitmq/ssl"
    tmpfs:
      - "/run:exec"
      - "/run/lock"
      - "/tmp:exec"
      - "/var/lib/journal"
      - "/var/opt/unifi/tmp:size=64m"
    ports:
      - 443:443
      - 5005:5005
      - 5671:5671
      - 6789:6789
      - 8080:8080
      - 8443:8443
      - 8444:8444
      - 8880:8880
      - 8881:8881
      - 8882:8882
      - 9543:9543
      - 11084:11084
      - 3478:3478/udp
      - 5514:5514/udp
      - 10003:10003/udp
    networks:
      frontend:
    sysctls:
      net.ipv4.ip_unprivileged_port_start: 443
    restart: "always"

volumes:
  os-server.var:
  os-server.log:
  os-server.data:
  os-server.srv:
  os-server.lib:
  os-server.db:
  os-server.rabbitmq.ssl:

networks:
  frontend:
```
To find out how you can change the default UID/GID of this container image, consult the [RTFM](https://github.com/11notes/RTFM/blob/main/linux/container/image/11notes/how-to.changeUIDGID.md#change-uidgid-the-correct-way).

# DEFAULT SETTINGS 🗃️
| Parameter | Value | Description |
| --- | --- | --- |
| `user` | docker | user name |
| `uid` | 1000 | [user identifier](https://en.wikipedia.org/wiki/User_identifier) |
| `gid` | 1000 | [group identifier](https://en.wikipedia.org/wiki/Group_identifier) |
| `home` | / | home directory of user docker |

# ENVIRONMENT 📝
| Parameter | Value | Default |
| --- | --- | --- |
| `TZ` | [Time Zone](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) | |
| `DEBUG` | Will activate debug option for container image and app (if available) | |

# MAIN TAGS 🏷️
These are the main tags for the image. There is also a tag for each commit and its shorthand sha256 value.

* [5.0.6](https://hub.docker.com/r/11notes/uosserver/tags?name=5.0.6)
* [5.0.6-unraid](https://hub.docker.com/r/11notes/uosserver/tags?name=5.0.6-unraid)
* [5.0.6-nobody](https://hub.docker.com/r/11notes/uosserver/tags?name=5.0.6-nobody)

### There is no latest tag, what am I supposed to do about updates?
It is my opinion that the ```:latest``` tag is a bad habbit and should not be used at all. Many developers introduce **breaking changes** in new releases. This would messed up everything for people who use ```:latest```. If you don’t want to change the tag to the latest [semver](https://semver.org/), simply use the short versions of [semver](https://semver.org/). Instead of using ```:5.0.6``` you can use ```:5``` or ```:5.0```. Since on each new version these tags are updated to the latest version of the software, using them is identical to using ```:latest``` but at least fixed to a major or minor version. Which in theory should not introduce breaking changes.

If you still insist on having the bleeding edge release of this app, simply use the ```:rolling``` tag, but be warned! You will get the latest version of the app instantly, regardless of breaking changes or security issues or what so ever. You do this at your own risk!

# REGISTRIES ☁️
```
docker pull 11notes/uosserver:5.0.6
docker pull ghcr.io/11notes/uosserver:5.0.6
docker pull quay.io/11notes/uosserver:5.0.6
```

# UNRAID VERSION 🟠
This image supports unraid by default. Simply add **-unraid** to any tag and the image will run as 99:100 instead of 1000:1000.

# NOBODY VERSION 👻
This image supports nobody by default. Simply add **-nobody** to any tag and the image will run as 65534:65534 instead of 1000:1000.

# SOURCE 💾
* [11notes/uosserver](https://github.com/11notes/docker-uosserver)

# PARENT IMAGE 🏛️
* [11notes/uosserver:fw-5.0.6](${{ json_readme_parent_url }})

# BUILT WITH 🧰
* [uosserver](https://community.ui.com/releases/r/uosserver/5.0.6)
* [11notes/util](https://github.com/11notes/docker-util)

# GENERAL TIPS 📌
> [!TIP]
>* Use a reverse proxy like Traefik, Nginx, HAproxy to terminate TLS and to protect your endpoints
>* Use Let’s Encrypt DNS-01 challenge to obtain valid SSL certificates for your services

# ElevenNotes™️
This image is provided to you at your own risk. Always make backups before updating an image to a different version. Check the [releases](https://github.com/11notes/docker-uosserver/releases) for breaking changes. If you have any problems with using this image simply raise an [issue](https://github.com/11notes/docker-uosserver/issues), thanks. If you have a question or inputs please create a new [discussion](https://github.com/11notes/docker-uosserver/discussions) instead of an issue. You can find all my other repositories on [github](https://github.com/11notes?tab=repositories).

*created 20.04.2026, 16:05:54 (CET)*