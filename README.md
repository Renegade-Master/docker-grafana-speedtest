# docker-grafana-speedtest

## Description

Docker-Compose deployment for creating a Grafana dashboard, backed by a Postgres
database.  The output of the Ookla Speedtest.net CLI tool writes to the database.

The intention of this deployment is to create a simple Internet Health Check
Dashboard.

This Docker image was build with the intended Host being a Raspberry PI 4, but
there is no reason why it cannot run anywhere else.

## Example Images

- Dashboard
  ![](./img/InternetHealthCheck%20-%20Grafana.png "Dashboard Example 1")

- Database
  
  ```
             timestamp           |      download      |       upload       |  ping   | bytes_sent | bytes_received |                      share
  -------------------------------+--------------------+--------------------+---------+------------+----------------+-------------------------------------------------
   2021-07-03 17:31:52.488105+00 |  21852981.45102463 |  23265454.66379635 |  65.421 |   29310976 |       28886512 | http://www.speedtest.net/result/11673739572.png
   2021-07-03 17:35:01.077231+00 | 14252342.850197388 |   20981610.2126279 |  57.608 |   26583040 |       17909508 | http://www.speedtest.net/result/11673750457.png
   2021-07-03 17:40:01.495294+00 |  10517407.81981884 | 21504911.172475275 |  67.227 |   27287552 |       13249284 | http://www.speedtest.net/result/11673767814.png
   2021-07-03 17:45:01.033392+00 |  6406464.107586999 |  15838016.99675269 |  65.836 |   21291008 |        8156300 | http://www.speedtest.net/result/11673784902.png
   2021-07-03 17:50:01.915597+00 |  7084157.602354868 | 19185927.985337697 |  58.661 |   24231936 |        9736964 | http://www.speedtest.net/result/11673802462.png
   2021-07-03 17:55:00.929206+00 | 10449298.473523138 | 12057307.551747277 |  70.689 |   15187968 |       13148736 | http://www.speedtest.net/result/11673819538.png
   2021-07-03 18:05:00.909505+00 |  24954550.65151375 |  16875021.17071964 |  57.293 |   21405696 |       31419393 | http://www.speedtest.net/result/11673855379.png
   2021-07-03 18:10:01.069168+00 | 15716179.743778327 |  23336177.57879359 |  60.961 |   29384704 |       20100592 | http://www.speedtest.net/result/11673872569.png
   2021-07-03 18:15:00.932734+00 |  12621304.53935426 | 20437007.293488678 |  65.808 |   26198016 |       16158468 | http://www.speedtest.net/result/11673889744.png
   2021-07-03 18:20:01.654659+00 |  6904538.577015014 |  19788176.74811917 |  76.845 |   24846336 |        8837696 | http://www.speedtest.net/result/11673907686.png
   2021-07-03 18:25:02.337254+00 | 14635041.826680405 | 17225036.197095957 |  50.378 |   21692416 |       18398900 | http://www.speedtest.net/result/11673925811.png
   2021-07-03 18:35:03.340413+00 |  1780214.005611139 |  8572333.178945964 | 895.635 |   11476992 |        2312752 | http://www.speedtest.net/result/11673960883.png
   2021-07-03 18:40:01.019869+00 | 23705113.343745794 | 28608959.659864817 |   96.62 |   36225024 |       31600388 | http://www.speedtest.net/result/11673976892.png
   2021-07-03 18:45:01.064943+00 | 21679871.085997894 | 17176975.166997552 |  82.993 |   21749760 |       27385937 | http://www.speedtest.net/result/11673993438.png
   2021-07-03 18:50:01.003216+00 | 14764615.798014143 | 28600127.626174692 |  59.146 |   35962880 |       18564868 | http://www.speedtest.net/result/11674009497.png
   2021-07-03 18:55:01.069302+00 | 13693673.757891873 | 26527013.116073083 |  77.632 |   33472512 |       17244184 | http://www.speedtest.net/result/11674025312.png
   2021-07-03 19:21:40.095221+00 | 22402147.507291242 | 29081976.080305226 |  75.137 |   36724736 |       30033668 | http://www.speedtest.net/result/11674109135.png
   2021-07-03 19:25:01.251125+00 |  20837749.38404466 | 29857197.247680496 |  82.225 |   37584896 |       26309633 | http://www.speedtest.net/result/11674119627.png
   2021-07-03 19:34:58.98777+00  |  26523961.98677843 |  17138199.57992225 |  65.585 |   21766144 |       33549589 | http://www.speedtest.net/result/11674150581.png
   2021-07-03 19:40:01.153069+00 | 17024885.969555225 |  30699982.34319679 |  67.329 |   38649856 |       23090672 | http://www.speedtest.net/result/11674166348.png
  ```

## Installation/Running

Steps for running the Docker-Compose deployment:

1. Clone/Download the repository.

2. Run the following command to bring the containers online.

   ```shell
   docker-compose build; docker-compose up
   ```

## Default Login Credentials

- Grafana

  | Username | Password |
  |----------|----------|
  | admin    | admin    |

- Postgres

  | Username | Password |
  |----------|----------|
  | postgres |          |

## Troubleshooting

- **"APK cannot connect"**
  - Missing required library on host.  Install the following

    ```shell
    wget "http://ftp.de.debian.org/debian/pool/main/libs/libseccomp/libseccomp2_2.5.1-1_armhf.deb"
    
    dpkg -i libseccomp2_2.5.1-1_armhf.deb
    ```
