#!/bin/bash
pkill -9 -f helios.py || true
cd `dirname "$0"` && make run
