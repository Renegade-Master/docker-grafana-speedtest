# Docker Grafana Speedtest

## Description

Docker-Compose deployment for creating a Grafana dashboard, backed by a Postgres database. The output of the Ookla
Speedtest.net CLI tool writes to the database.

The intention of this deployment is to create a simple Internet Health Check Dashboard.

This Docker image was build with the intended host being a Raspberry PI 4 running 32-bit Raspbian, but it will run 
on any machine capable of running Docker. It is compatible with 32-bit systems.

## Example Images

- Dashboard
  ![](./img/InternetHealthCheck%20-%20Grafana.png "Dashboard Example 1")

- Database

    type  |       timestamp        | ping_jitter | ping_latency | download_bandwidth | download_bytes | download_elapsed | upload_bandwidth | upload_bytes | upload_elapsed |     packetloss      |      isp      |  result_id  |    result_url
  --------|------------------------|-------------|--------------|--------------------|----------------|------------------|------------------|--------------|----------------|---------------------|---------------|-------------|------------------
   result | 2021-07-12 23:56:40+00 |       4.153 |       42.964 |            1948966 |       30263552 |            15000 |          2649820 |     25742208 |           9711 | 0.33444816053511706 | Three Ireland | <result_id> | <link_to_result>
   result | 2021-07-13 00:00:35+00 |       3.743 |       39.684 |            2511049 |       35756160 |            15001 |          3756017 |     48417024 |          13302 |                   0 | Three Ireland | <result_id> | <link_to_result>
   result | 2021-07-13 00:05:53+00 |      12.722 |       28.636 |            3234516 |       33908864 |            10702 |          3105898 |     45029376 |          15000 |                   0 | Three Ireland | <result_id> | <link_to_result>
   result | 2021-07-13 00:15:34+00 |       9.527 |       24.937 |            2754997 |       33717376 |            13015 |          3849669 |     54410880 |          15001 |                   0 | Three Ireland | <result_id> | <link_to_result>
   result | 2021-07-13 00:30:28+00 |      17.792 |       28.864 |            3342954 |       38793216 |            11615 |          3743506 |     32680704 |           9011 |                   0 | Three Ireland | <result_id> | <link_to_result>
   result | 2021-07-13 00:43:40+00 |      12.308 |       38.725 |            4403536 |       60031488 |            15004 |          3442702 |     35385728 |          10313 |                   0 | Three Ireland | <result_id> | <link_to_result>
   result | 2021-07-13 00:58:02+00 |      18.829 |       29.802 |            3805086 |       51518720 |            13610 |          3305735 |     23492608 |           6902 |                   0 | Three Ireland | <result_id> | <link_to_result>
   result | 2021-07-13 01:00:27+00 |       6.632 |       46.076 |            3630412 |       45603840 |            15002 |          3547809 |     14530048 |           4100 |                   0 | Three Ireland | <result_id> | <link_to_result>
   result | 2021-07-13 01:15:30+00 |      20.161 |       51.106 |            3681545 |       48687232 |            15016 |          3331651 |     20683136 |           6211 |                   0 | Three Ireland | <result_id> | <link_to_result>
   result | 2021-07-13 01:30:29+00 |       2.493 |       30.268 |            7839970 |       85003776 |            11303 |          3391554 |     20413056 |           6011 |                   0 | Three Ireland | <result_id> | <link_to_result>
   result | 2021-07-13 01:45:27+00 |       8.066 |       29.272 |            7884289 |       85360000 |            11502 |          3337812 |     27271424 |           8212 |                   0 | Three Ireland | <result_id> | <link_to_result>
   result | 2021-07-13 02:00:36+00 |       5.044 |       37.943 |            3539327 |       52663424 |            15007 |          2711022 |     39677440 |          15013 |  3.3444816053511706 | Three Ireland | <result_id> | <link_to_result>
   result | 2021-07-13 02:15:25+00 |       0.221 |       49.695 |            3335805 |       33282304 |            10016 |          3365187 |     27819392 |           8306 |                   0 | Three Ireland | <result_id> | <link_to_result>
   result | 2021-07-13 02:30:24+00 |       0.063 |       39.834 |            3976865 |       39597184 |             9908 |          3353327 |     22381568 |           6609 |                   0 | Three Ireland | <result_id> | <link_to_result>


## Installation/Running

### Docker Compose

Steps for running the Docker-Compose deployment:

1. Clone/Download the repository.

2. Run the following command from the root of the repository to bring the containers online.

   ```shell
   docker-compose up
   ```

### Helm

Steps for installing the Helm Chart:

1. Add the Chart repository:

   ```shell
   helm repo add <repo_name> "https://renegade-master.github.io/docker-grafana-speedtest/"
   ```

2. Install chart with:

   ```shell
   helm install [--namespace <namespace>] <name> <repo_name>/grafana-speedtest --version <version> [--devel] [--debug]
   ```

## Default Login Credentials

- Grafana

  | Username | Password |
  |----------|----------|
  | admin    | admin    |

- Postgres

  | Username | Password |
  |----------|----------|
  | postgres | password |

## Troubleshooting

- **"APK cannot connect"**
    - Missing required library on host. Install the following

      ```shell
      wget "https://ftp.de.debian.org/debian/pool/main/libs/libseccomp/libseccomp2_2.5.1-1_armhf.deb"
      
      dpkg -i libseccomp2_2.5.1-1_armhf.deb
      ```
