docker run -ti -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v /home/atom/apps/dosbox/data:/root/dosbox -v /home/atom/apps/dosbox/.dosbox:/root/.dosbox --name dosbox lacsap/dosbox
