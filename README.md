# ctfd-setup

## Configure container challenges:
1. Go to /containers/admin/settings and set all settings.
   1. Set base-url to: unix://var/run/docker.sock (If you want to deploy continers to same host as ctfd is hosted at)
   2. Hostname for Docker Host: The adress which the users will connect to the container with.
   3. Container Expiration in Minutes: The amont of minutes before the continers expiers. I would recoment 30 min or something
   4. Max Containers Per User/Team: Depends on how big ctf you host.
   5. Maximum per-container memory usage (in MB): Depends on recources but 512 should be good i guess.
   6. Maximum per-container CPUs:Depends on recources but 0.5 should be good i guess.


## Themes
- To add a theme just drop it in to themes and rebuild the container

## Add Plugins
1. Drop it in to plugins
2. Add the pip requirements to plugins/requirements.txt
3. rebuild container


## Thanks to
- [CTFd](https://github.com/CTFd/CTFd) - Platform
- [CTFd-Docker-Plugin](https://github.com/jabb4/CTFd-Docker-Plugin) - Plugin