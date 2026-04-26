#!/bin/bash
rm schema.json
rm custom-elements.json
wget https://cdn.jsdelivr.net/npm/@m3e/web@latest/dist/custom-elements.json
wget https://raw.githubusercontent.com/webcomponents/custom-elements-manifest/refs/heads/main/schema.json
go tool github.com/atombender/go-jsonschema -o cem.go --only-models -p generator schema.json

export DESTINATION="/home/bruce/Dropbox/Code/m3e/"
export M3E_SOURCE="/home/bruce/Documents/m3e/"

pushd ${M3E_SOURCE}
git fetch
git pull
popd

make build
./generator
pushd ../src/m3e/ ; gleam format; gleam check; popd
