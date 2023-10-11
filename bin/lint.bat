echo " "
echo "===================robles==================="
echo " Welcome to the robles linter."
echo "============================================"
echo " "

docker pull razeware/robles:release-v2
docker run --rm -v "%cd%:/data/src" razeware/robles:release-v2 bin/robles book lint --without-edition
