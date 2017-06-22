#!/bin/bash
echo "Cleaning up tupped files..."
rm -rf ./lapis/cache/cache.lua
rf -rf ./lapis/cache/engines/engine.lua
rm -rf ./lapis/cache/engines/redis.lua

tup monitor -a -f
