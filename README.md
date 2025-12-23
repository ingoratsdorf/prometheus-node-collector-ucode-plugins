# prometheus-node-collector-ucode (Plugins)
Collector modules for openwrt ucode prometheus collector

## thermal.uc

Creates metrics from thermal zones, in line with the lua exporter.

```
# TYPE node_thermal_zone_temp gauge
node_thermal_zone_temp{zone="thermal_zone0",type="cpu-thermal",policy="step_wise",passive="",mode="enabled"} 54.5
node_scrape_collector_duration_seconds{collector="thermal"} 0.000943608
node_scrape_collector_success{collector="thermal"} 1
```

