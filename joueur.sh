#!/bin/bash
# joueur.sh

PORT_IA=3708

if [ "$#" -ne 3 ]; then
  echo "Usage: $0 hostServeur portServeur nomJoueur" >&2
  exit 1
fi

make
cd ./src
make
../bin/player $1 $2 $PORT_IA $3 & java -Djava.library.path="../lib" -classpath ../lib/sicstus-4.4.1/bin/jasper.jar:. IAClient $1 $PORT_IA && fg
