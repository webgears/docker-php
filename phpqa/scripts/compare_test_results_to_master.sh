#!/bin/bash

PHPQA_JOB_NAME=${1:-"phpqa"}

CURRENT_TEST_DIR="test/phpqa/"
MASTER_TEST_DIR="master-phpqa/test/phpqa/"

echo "Fetching $PHPQA_JOB_NAME master build artifacts"
curl -L --header "PRIVATE-TOKEN: $GITLAB_TOKEN" "https://gitlab.com/api/v4/projects/$CI_PROJECT_ID/jobs/artifacts/master/download?job=$PHPQA_JOB_NAME" --output master-phpqa.zip
unzip master-phpqa.zip -d master-phpqa *.xml

echo "Formatting xml files"
for file in "phpcpd.xml" "phpmnd.xml"; do
    xmllint --format $MASTER_TEST_DIR$file > _temp.xml
    mv -f _temp.xml $MASTER_TEST_DIR$file
    xmllint --format $CURRENT_TEST_DIR$file > _temp.xml
    mv -f _temp.xml $CURRENT_TEST_DIR$file
done

for file in ${CURRENT_TEST_DIR}*.xml; do
    echo "processing $file"
    file=${file#$CURRENT_TEST_DIR}
    diff -U 5 $MASTER_TEST_DIR$file $CURRENT_TEST_DIR$file | diff2html -s side -i stdin -o stdout > $CURRENT_TEST_DIR${file}.diff.html
done
