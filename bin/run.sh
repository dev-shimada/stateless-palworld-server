#!/bin/bash

echo start

aws s3 sync $STORE $DATA_DIR/Pal/Saved && echo loaded && \
while true; do sleep 30s && aws s3 sync --delete $DATA_DIR/Pal/Saved $STORE && echo saved; done&
/bin/bash $DATA_DIR/PalServer.sh -useperfthreads -NoAsyncLoadingThread -UseMultithreadForDS port=18221

echo end
