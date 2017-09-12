# Protograph

[![Build Status](https://travis-ci.org/protograph/protograph.svg?branch=master)](https://travis-ci.org/protograph/protograph)

Protograph is a collection of sequence diagrams of various protocols.

Protograph generations requires protographer and LaTeX.

Project structure:

1. Subdirectories contains the markdown (protograph) describing the protocols
2. TEX and PDF files are generated in the same subdirectories.

Installing protographer and latex docker image:
```
make prepare
```

Generating protograph:
```
make all
```

Please see https://github.com/protograph/protographer/blob/master/testdata/helloworld.md and https://github.com/protograph/protographer/blob/master/testdata/helloworld.pdf to get a taste of how the conversions work.
