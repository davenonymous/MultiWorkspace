#!/bin/bash

cmd.exe /c gradlew workspace:runData

rm -rf "BonsaiTrees/src/generated/resources/"
mkdir "BonsaiTrees/src/generated/resources/"

cp -r workspace/src/generated/resources/bonsaitrees3/* "BonsaiTrees/src/generated/resources/"

rm -rf BonsaiTrees/src/generated/resources/.cache
rm -f BonsaiTrees/src/generated/resources/cache

rm -rf "libnonymous/src/generated/resources/"
mkdir "libnonymous/src/generated/resources/"

cp -r workspace/src/generated/resources/libnonymous/* "libnonymous/src/generated/resources/"

rm -rf libnonymous/src/generated/resources/.cache
rm -f libnonymous/src/generated/resources/cache

rm -rf "SlimeClicker/src/generated/resources/"
mkdir "SlimeClicker/src/generated/resources/"

cp -r workspace/src/generated/resources/slimeclicker/* "SlimeClicker/src/generated/resources/"

rm -rf SlimeClicker/src/generated/resources/.cache
rm -f SlimeClicker/src/generated/resources/cache
