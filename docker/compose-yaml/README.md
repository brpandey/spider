### Useful docker-compose yaml files

* postgres-pgadmin setup
### test out postgres sql locally, remember to register server in pgadmin, setup connections tab, queries (Tools->Query)
```bash
dstart
docker compose -f compose-yaml/postgres.yml up -d
dps
dstatus
docker compose -f compose-yaml/postgres.yml down
dstop
```

* Add more useful ones here...
