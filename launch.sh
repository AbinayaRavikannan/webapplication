#!/bin/bash
sed "s/BuildNumber/$1/g" deployment.yml > myapp-deployment.yml
