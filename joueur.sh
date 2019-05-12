#!/bin/bash
# joueur.sh

if [ "$#" -ne 3 ]; then
  echo "Usage: $0 hostServeur portServeur nomJoueur" >&2
  exit 1
fi

make
cd ./src
make
../bin/player $1 $2 3708 $3 & java -Djava.library.path="../lib" -classpath ../lib/sicstus-4.4.1/bin/jasper.jar:. IAClient $1 3708 && fg
