#!/bin/bash

function mongo_local_start() {
  mongod >> ~/mongo/output.log 2>&1 &
}

function mongo_port() {
  lsof -iTCP -sTCP:LISTEN | grep mongo | awk '{print $9}'
}
