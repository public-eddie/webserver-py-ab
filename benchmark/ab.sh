#!/bin/sh

ab -p req.json -T 'application/json; charset=utf-8' -e aaa.csv -c 1 -n 1 10.0.7.1:32100/test