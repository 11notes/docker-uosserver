${{ title_caution }}
${{ github:> [!CAUTION] }}
${{ github:> }}To run this image safely, since it needs access to certain resources of your host, run it via ```sysbox``` runtime and not the default Docker runtime if you are **not using rootless runtimes**!
${{ github:> }}This image is in active development, there could be potential major changes on how this image handles volumes, data, etc!

${{ content_synopsis }} This image will provide you a rock solid Unifi OS server image. This image breaks (currently) all container philosophies by running multiple containers inside this image that are managed by the Unifi OS Server. This means updates to the apps inside the image are handled by the Unifi OS Server, not the image. Only the Unifi OS Server image itself is handled by this image. Consider running a VM instead of a container for this.

${{ content_uvp }} Good question! Because ...

${{ github:> [!IMPORTANT] }}
${{ github:> }}* ... this image is auto updated to the latest version via CI/CD
${{ github:> }}* ... this image has a health check
${{ github:> }}* ... this image is created via a secure and pinned CI/CD process

If you value security, simplicity and optimizations to the extreme, then this image might be for you.

${{ title_volumes }}
* **/sys/fs/cgroup** - Directory on your host to access cgroups
* **/persistent** - Directory of package manager
* **/data** - Directory of all application data
* **/srv** - Directory of service specific data
* **/var/lib/unifi** - Directory of Unifi Network Controller data
* **/var/lib/mongodb** - Directory of mongodb
* **/etc/rabbitmq/ssl** - Directory of self-signed SSL certificates for RabbitMQ

${{ content_compose }}

${{ content_defaults }}

${{ content_environment }}

${{ content_source }}

${{ content_parent }}

${{ content_built }}

${{ content_tips }}