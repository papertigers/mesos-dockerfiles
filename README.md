# Mesos + Marathon on Triton

This is a Docker Compose file and shell script that will deploy a Mesos with Marathon environment that can run Mesos and Marathon tasks.

## Prep your environment

1. [Get a Joyent account](https://my.joyent.com/landing/signup/) and [add your SSH key](https://docs.joyent.com/public-cloud/getting-started).
1. Install and the [Docker Engine](https://docs.docker.com/installation/mac/) (including Docker Compose) on your laptop or other environment, along with the [Joyent CloudAPI CLI tools](https://apidocs.joyent.com/cloudapi/#getting-started).
1. [Configure your Docker CLI and Compose for use with Joyent](https://docs.joyent.com/public-cloud/api-access/docker):

```
curl -O https://raw.githubusercontent.com/joyent/sdc-docker/master/tools/sdc-docker-setup.sh && chmod +x sdc-docker-setup.sh
 ./sdc-docker-setup.sh -k us-east-1.api.joyent.com <ACCOUNT> ~/.ssh/<PRIVATE_KEY_FILE>
```

## Instructions

1. [Clone](git@github.com:joyent/mesos-dockerfiles.git) or [download](https://github.com/joyent/mesos-dockerfiles/archive/master.zip) this repo.
1. `cd` into the cloned or downloaded directory.
1. Execute `bash start.sh` to start everything up.
1. The Mesos and Marathon dashboards should automatically open in your browser, or follow the links output by the `start.sh` script above.
1. The `start.sh` script will register two sample tasks, each using three instances. Scale those up or down, or delete as you wish.

## Next steps

- Create your own Mesos+Marathon tasks
- Try a different Mesos framework
- Take over the world
- Profit

