#!/bin/bash

git remote -v

#prot=https
prot=git

git remote set-url origin $prot@github.com:rprobinson/FHIR_BaRS.git

git remote -v
