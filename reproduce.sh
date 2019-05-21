#!/bin/bash
BAD_COMMIT=3c12eb8d1418181af93abdd466c64dcddf68ce16
URL=https://github.com/file/file/

git clone $URL && cd file

git branch bad $BAD_COMMIT && git checkout bad

autoreconf -i && ./configure && make --quiet

echo "this should produce modulo^32 output"
./src/file -m magic/magic ../test1.gz

echo "checking out previous commit and re-building"

git reset --hard HEAD^ && make  --quiet
echo "this should produce non modulo^32 output"
./src/file -m magic/magic ../test1.gz
