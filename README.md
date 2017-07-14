## PrivateBin
Docker image for https://github.com/PrivateBin/PrivateBin

# Components/Features
- Fedora:latest
- Apache
- PHP
- PrivateBin - https://github.com/PrivateBin/PrivateBin
- Running under non-root user
- Runs in OpenShift

# Configuration
- Persistent data -> use volume `/opt/privatebin/data` (`/opt/privatebin/run` is just for httpd pid file)
