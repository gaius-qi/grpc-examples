#!/bin/bash

PROTOC_ALL_IMAGE=${PROTOC_ALL_IMAGE:-"namely/protoc-all:1.51_1"}
PROTO_PATH=pkg/apis
LANGUAGE=go

proto_modules="common"

echo "generate protos..."

for module in ${proto_modules}; do
  if docker run --rm -v $PWD:/defs ${PROTOC_ALL_IMAGE} \
    -d ${PROTO_PATH}/$module -i . \
    -l ${LANGUAGE} -o . \
    --go-source-relative \
    --with-validator \
    --validator-source-relative; then
    echo "generate protos ${module} successfully"
  else
    echo "generate protos ${module} failed"
  fi
done
