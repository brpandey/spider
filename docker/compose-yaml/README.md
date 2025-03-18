### Useful docker-compose yaml files

* postgres-pgadmin setup
#### Test out postgres sql locally
#### Note: emember to register server in pgadmin, setup connections tab, queries (Tools->Query)
```bash
dstart
docker compose -f compose-yaml/postgres.yml up -d
dps
dstatus
docker compose -f compose-yaml/postgres.yml down
dstop
```

* Add more useful ones here...
