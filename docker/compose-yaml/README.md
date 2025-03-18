### Useful docker-compose yaml files

* postgres-pgadmin setup
```bash
# Test out postgres sql locally
# Note: Remember to register server in pgadmin, setup connections tab, queries (Tools->Query)
dstart
docker compose -f compose-yaml/postgres.yml up -d
dps
dstatus
docker compose -f compose-yaml/postgres.yml down
dstop
```

* Add more useful ones here...
