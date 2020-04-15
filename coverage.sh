curl -s https://codecov.io/bash > coverage/.codecov
sed -i -e 's/TRAVIS_.*_VERSION/^TRAVIS_.*_VERSION=/' coverage/.codecov
chmod +x coverage/.codecov
./coverage/.codecov