# docker-grafana-speedtest

## Description

Docker-Compose deployment for creating a Grafana dashboard, backed by a Redis
database.  The database is written to by the Ookla Speedtest.net CLI tool.

The intention of this deployment is to create a simple Internet Health Check
Dashboard.

This Docker image was build with the intended Host being a Raspberry PI 4, but
there is no reason why it cannot run anywhere else.


## Troubleshooting

- **"Redis cannot start" or "APK cannot connect"**
  - Missing required library on host.  Install the following

    ```shell
    wget "http://ftp.de.debian.org/debian/pool/main/libs/libseccomp/libseccomp2_2.5.1-1_armhf.deb"
    dpkg -i libseccomp2_2.5.1-1_armhf.deb
    ```
