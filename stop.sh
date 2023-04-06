#!/bin/bash

# Read PIDs from the file and kill the processes
if [ -f pids.txt ]; then
  while read pid; do
    kill $pid
  done < pids.txt

  # Remove the PIDs file after killing the processes
  rm -f pids.txt
fi

# Stop the subgraph Docker container
(
  cd subgraph
  docker-compose down
)
