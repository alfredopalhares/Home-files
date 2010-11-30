#!bin/bash

# Auto call git when planying minecraft 

cd /home/masterkorp/.minecraft/

git pull
minecraft

git add .
git commit -m "Auto commit in : `date`"
git push

exit 0
