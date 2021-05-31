#!/bin/bash

DATASTORE=$(docker ps | grep _datastore-db | cut -d ' ' -f 1)
DB=$(docker ps | grep _db | cut -d ' ' -f 1)
FECHA=(`date +%d-%m-%Y"_"%H_%M_%S`)

echo $FECHA

echo "REALIZANDO RESPALDO DE DB"
docker exec -t $DB pg_dumpall -c -U postgres > db.sql

echo "COMPRIMIENDO RESPALDO"
tar -czf db_$FECHA.tar.gz db.sql

echo "REALIZANDO RESPALDO DE DATASTORE"
docker exec -t $DATASTORE pg_dumpall -c -U postgres > datastore-db.sql

echo "COMPRIMIENDO RESPALDO"
tar -czf datastore-db_$FECHA.tar.gz datastore-db.sql

echo "ELIMIANDO TEMPORALES"
rm -f db.sql
rm -f datastore-db.sql

echo "FINALIZADO"
