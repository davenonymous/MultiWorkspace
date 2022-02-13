#!/bin/bash

main() {
  cmd.exe /c gradlew workspace:runData

  declare -A mods
  mods[bonsaitrees3]="BonsaiTrees"
  mods[libnonymous]="libnonymous"
  mods[slimeclicker]="SlimeClicker"
  mods[riddlechests]="RiddleChests"
  mods[pipegoggles]="PipeGoggles"

  for modId in "${!mods[@]}"; do
    local modPath=${mods[$modId]}
    rm -rf "./${modPath}/src/generated/resources/"
    mkdir -p "./${modPath}/src/generated/resources/"

    cp -r workspace/src/generated/resources/${modId}/* "${modPath}/src/generated/resources/"

    rm -rf "./${modPath}/src/generated/resources/.cache"
    rm -f "./${modPath}/src/generated/resources/cache"

  done
}

main