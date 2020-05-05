#!/usr/bin/env bash

DEST_DIR=${1:-"test/junit/"}
SOURCE_DIR=${2:-"test/result/"}
JUNIT_FILE=${DEST_DIR}${3:-features.xml}
mkdir -p $DEST_DIR
rm -f $JUNIT_FILE

for file in ${SOURCE_DIR}*.xml; do
  echo "Merging jUnit report $file into $JUNIT_FILE"
  if [ -f $JUNIT_FILE ]; then
    head -n -1 $JUNIT_FILE > $JUNIT_FILE.new
    tail -n +3 $file >> $JUNIT_FILE.new
    mv -f $JUNIT_FILE.new $JUNIT_FILE
  else
    cp $file $JUNIT_FILE
  fi
done
