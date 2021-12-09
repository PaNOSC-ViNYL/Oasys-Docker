# Oasys Local Docker

In order to run to container clone this repo

```
git clone https://gitlab.elettra.eu/panosc/ceric/oasys-local-docker.git
cd oasys-local-docker.git
docker pull ceric/panosc-oasys-local:oasys.20
bash runn.sh

```

## What does runn.sh

this container run with the UID 1000 (user oasys)

`--volume=$HOME:/home/oasys:rw `

it binds mount your home folder to oasys's home, all file created from the container will be owned by uid 1000


This is the content of runn.sh
```bash
#!/bin/bash
XSOCK=/tmp/.X11-unix
# xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -


docker run -it  --volume=$HOME:/home/oasys:rw     \
                --volume=$XSOCK:$XSOCK:rw   \
                --env="DISPLAY"             \
                --env="QT_X11_NO_MITSHM=1"  \
                --user=oasys               \
                --device=/dev/dri:/dev/dri ceric/panosc-oasys-local:oasys.20
```


## TODO

- [ ] setup a CI/CD Pipeline with a gitlab runner
