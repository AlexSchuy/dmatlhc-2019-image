DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
TAG="dmatlhc2019/empty"

echo "$DOCKER_PASSWORD" | docker login --username $DOCKER_USERNAME --password-stdin
docker build -t $TAG $DIR
docker push $TAG
docker images
