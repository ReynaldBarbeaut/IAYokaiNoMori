#!/bin/bash
# joueur.sh

if [ "$#" -ne 4 ]; then
  echo "Usage: $0 hostServeur portServeur nomJoueur sensTete" >&2
  exit 1
fi

make
cd ./src
make
cd ../
echo "coucou"
./bin/player $1 $2 $3 $4

java -Djava.library.path="/usr/local/sicstus4.4.1/bin/jasper.jar" -classpath ./jasper/jasper.jar:. ./src/IAClient $1 4242

