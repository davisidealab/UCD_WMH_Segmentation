#!/bin/bash

if [ $# -gt 2 ]; then
    t1=$(readlink -f $1)
    t1mask=$(readlink -f $2)
    flair=$(readlink -f $3)
    if [ $# -eq 4 ]; then
        deltemp=$4
    fi
else
    echo "run_ucdwmhkit.sh <Raw 3DT1> <3DT1 stripped Mask> <Raw FLAIR> --delete-temporary"
    exit 1
fi

t1path=$(dirname $(readlink -f "$t1"))
t1maskpath=$(dirname $(readlink -f "$t1mask"))
flairpath=$(dirname $(readlink -f "$flair"))
volumes="-v $t1path:$t1path"
if [ $t1path != $t1maskpath ]; then
    volumes="$volumes -v $t1maskpath:$t1maskpath"
fi
if [ $t1path != $flairpath ]; then
    volumes="$volumes -v $flairpath:$flairpath"
fi

echo "t1: $t1"
echo "t1mask: $t1mask"
echo "flair: $flair"

echo "docker run --privileged --rm $volumes ucd_wmhkit /opt/UCDWMHSegmentation-1.3/ucd_wmh_segmentation/ucd_wmh_segmentation.py $t1 $t1mask $flair $deltemp"
docker run --privileged --rm $volumes ucd_wmhkit /opt/UCDWMHSegmentation-1.3/ucd_wmh_segmentation/ucd_wmh_segmentation.py $t1 $t1mask $flair $deltemp
