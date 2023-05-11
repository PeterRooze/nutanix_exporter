
# Running the exporter

    nutanix_exporter -nutanix.url https://nutanix_cluster:9440 -nutanix.username <user> -nutanix.password <password>

    localhost:9405/metrics

# Use config file for ease of use and stability

    nutanix_exporter -nutanix.conf ./config.yml

During the Query pass GET-Parameter Section

    localhost:9405/metrics?section=<target>


Config
```
default:
  nutanix_host: https://nutanix.cluster.local:9440
  nutanix_user: prometheus
  nutanix_password: PW

cluster02:
  nutanix_host: https://nutanix02.cluster.local:9440
  nutanix_user: prometheus
  nutanix_password: PW
```

# Prometheus extendended Configuration

Nutanix Config:
```
nutanix.cluster.local:
  nutanix_host: https://nutanix.cluster.local:9440
  nutanix_user: prometheus
  nutanix_password: PW

nutanix02.cluster.local:
  nutanix_host: https://nutanix02.cluster.local:9440
  nutanix_user: prometheus
  nutanix_password: PW
```

Prometheus Config:
```
scrape_configs:
  - job_name: nutanix_export
    metrics_path: /metrics
    static_configs:
    - targets:
      - nutanix.cluster.local
      - nutanix02.cluster.local
    relabel_configs:
    - source_labels: [__address__]
      target_label: __param_section
    - source_labels: [__address__]
      target_label: __param_target
    - source_labels: [__param_target]
      target_label: instance
    - target_label: __address__
      replacement: <ipadressNodeExporter>:9405
```

