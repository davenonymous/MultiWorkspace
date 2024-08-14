#!/bin/bash

main() {
  declare -A mods
  mods[bonsaitrees3]="BonsaiTrees"
  mods[libnonymous]="libnonymous"

  rm -rf "./dist/"
  mkdir -p "./dist/"

  for modId in "${!mods[@]}"; do
    local modPath=${mods[$modId]}
    cd $modPath
    pwd
    cmd.exe /c gradlew reobfJar
    cd ..

    local latestBuild=$(/usr/bin/ls -1t ${modPath}/build/libs/ | head -n1)
    cp ${modPath}/build/libs/${latestBuild} "./dist/"
  done
}

main