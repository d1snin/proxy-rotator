#!/bin/bash

#
# Copyright 2024 Mikhail Titov
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Ensure required environment variables are set
if [ -z "$PORT" ] || [ -z "$TARGETS" ] || [ -z "$LIFETIME" ]; then
    echo "Required environment variables PORT, TARGETS, or LIFETIME not set in .env"
    exit 1
fi

# Split the targets by comma into an array
IFS=',' read -r -a target_array <<< "$TARGETS"

# Infinite loop to rotate proxies
while true; do
    for target in "${target_array[@]}"; do
        # Start the proxy command
        echo "Rotating to $target..."
        /usr/local/bin/proxy tcp --trace -p :"$PORT" -P "$target" &

        # Get the PID of the background process
        proxy_pid=$!

        # Wait for the lifetime duration
        sleep "$LIFETIME"

        # Kill the previous proxy process to rotate to the next target
        kill "$proxy_pid"
    done
done