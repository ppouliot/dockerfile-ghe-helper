set -ex
# SET THE FOLLOWING VARIABLES
# docker hub username
USERNAME=ppouliot
# image name
IMAGE=ghe-helper
docker build --no-cache -t $USERNAME/$IMAGE:latest .
