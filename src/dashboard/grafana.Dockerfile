FROM grafana/grafana:latest

ADD ./dashboards /etc/grafana/provisioning/dashboards
