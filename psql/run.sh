#!/bin/bash

sudo docker build -t alpine-postgres .
sudo docker run -t -i alpine-postgres /bin/bash

echo "Done!"
exit 0

