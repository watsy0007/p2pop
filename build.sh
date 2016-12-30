#!/usr/bin/env bash

cp -r src p2pop.popclipext
zip -r p2popclipext.zip p2pop.popclipext
mv p2popclipext.zip p2pop.popclipextz
rm -rf p2pop.popclipext
echo 'build done'
