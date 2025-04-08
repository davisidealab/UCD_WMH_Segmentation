#!/bin/bash

# Default values
deltemp=""
mi_option=""

# Function to print usage
usage() {
    echo "Usage: run_ucdwmhkit.sh <Raw 3DT1> <3DT1 stripped Mask> <Raw FLAIR> [--delete-temporary] [--mi]"
    exit 1
}

# Check minimum number of arguments
if [ $# -lt 3 ]; then
    usage
fi

# Parse required arguments
t1=$(readlink -f "$1")
t1mask=$(readlink -f "$2")
flair=$(readlink -f "$3")

# Shift past the three required arguments
shift 3

# Parse optional flags
while [[ $# -gt 0 ]]; do
    case "$1" in
        --delete-temporary)
            deltemp="--delete-temporary"
            ;;
        --mi)
            mi_option="--mi"
            ;;
        *)
            echo "Unknown option: $1"
            usage
            ;;
    esac
    shift
done

# Setup volume mounts
t1path=$(dirname "$t1")
t1maskpath=$(dirname "$t1mask")
flairpath=$(dirname "$flair")
volumes="-v $t1path:$t1path"

if [ "$t1path" != "$t1maskpath" ]; then
    volumes="$volumes -v $t1maskpath:$t1maskpath"
fi
if [ "$t1path" != "$flairpath" ]; then
    volumes="$volumes -v $flairpath:$flairpath"
fi

# Display inputs
echo "t1: $t1"
echo "t1mask: $t1mask"
echo "flair: $flair"
echo "deltemp: $deltemp"
echo "mi_option: $mi_option"

# Run the Docker container
echo "/usr/bin/docker run --privileged --rm $volumes ucd_wmhkit /opt/UCDWMHSegmentation-1.3/ucd_wmh_segmentation/ucd_wmh_segmentation.py $t1 $t1mask $flair $deltemp $mi_option"
/usr/bin/docker run --privileged --rm $volumes ucd_wmhkit /opt/UCDWMHSegmentation-1.3/ucd_wmh_segmentation/ucd_wmh_segmentation.py "$t1" "$t1mask" "$flair" $deltemp $mi_option
