#!/bin/bash

echo "API call #1. Don't process data:"
response=$(
  curl \
    -s \
    -H "Content-Type: application/json" \
    -X POST \
    --data @api_test_params.json \
    http://localhost:3000/organizations?process=false
)
echo -e "${response}\n"

echo "API call #2. Process data, with incorrect data passed:"
response=$(
  curl \
    -s \
    -H "Content-Type: application/json" \
    -X POST \
    --data '{"id":"100"}' \
    http://localhost:3000/organizations?process=true
)
echo -e "${response}\n"

echo "API call #3. Process correct data:"
response=$(
  curl \
    -s \
    -H "Content-Type: application/json" \
    -X POST \
    --data @api_test_params.json \
    http://localhost:3000/organizations?process=true
)
echo -e "${response}\n"

exit 0
