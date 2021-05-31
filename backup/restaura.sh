#!/bin/bash

DATASTORE=$(docker ps | grep _datastore-db | cut -d ' ' -f 1)
DB=$(docker ps | grep _db | cut -d ' ' -f 1)

echo $FECHA

echo "DESCOMPRIMIENDO RESPALDO DB"
tar xzf $1

echo "RESTAURANDO RESPALDO DE DB"
cat db.sql | docker exec -i $DB pgsql -U postgres

echo "DESCOMPRIMIENDO RESPALDO DATASTORE"
tar xzf $2

echo "RESTAURANDO RESPALDO DE DATASTORE"
cat datastore-db.sql | docker exec -i $DATASTORE psql -U postgres

echo "ELIMIANDO TEMPORALES"
rm -f db.sql
rm -f datastore-db.sql

echo "FINALIZADO"
