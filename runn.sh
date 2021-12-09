XSOCK=/tmp/.X11-unix
# xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -


docker run -it  --volume=$HOME:/home/oasys:rw     \
                --volume=$XSOCK:$XSOCK:rw   \
                --env="DISPLAY"             \
                --env="QT_X11_NO_MITSHM=1"  \
                --user=oasys               \
                --device=/dev/dri:/dev/dri oasys:20
