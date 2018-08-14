## Overview
The docker image for curator is based on alpine to have a small image footprint

## Usage Quick Start
Start container specifying the environment settings for Curator configuration and actions.
Currently the only action executed by the docker run is to remove old Elasticsearch indices
leaving only a configurable amount of days

```
docker run --rm --name curator \
  -e ELASTICSEARCH_HOST=localhost \
  -e ELASTICSEARCH_PORT=9200 \
  -e SSL=True \
  meteogroup/curator:latest
```
List of environment settings:
- ELASTICSEARCH_HOST - endpoint address to connect to Elastisearch cluster, default "localhost"
- ELASTICSEARCH_PORT - endpoint port to connect to cluster, default 9200
- SSL - if access to Elasticsearch is protected by SSL, has to be "True", default "False"
- INDEX_PREFIX - name for the prefix, default "dataprovisioning*"
- TIME_STRING - default '%Y.%m.%d'
- KEEP_DAYS - default 14
