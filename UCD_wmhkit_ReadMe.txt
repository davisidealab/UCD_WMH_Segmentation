# This kit will launch a docker container to run wmhkit and exit when done.

# Use the releases tag to first install the docker container image of wmhkit.


# Running (Can launch any number of instances):

# 1. To check the usage of the script:
sudo bash run_ucdwmhkit.sh


# 2. Example run command:
sudo bash /path/run_ucdwmhkit.sh /path/t1.nii.gz /path/t1mask.nii.gz /path/flair.nii.gz

# Replace "/path/t1.nii.gz", "/path/t1mask.nii.gz", and "/path/flair.nii.gz" with the appropriate file paths for your data. This command launches a Docker container with the specified data.
