# Protograph

[![Build Status](https://travis-ci.org/protograph/protograph.svg?branch=master)](https://travis-ci.org/protograph/protograph)

Protograph is a collection of sequence diagrams of various protocols.

Protograph generations requires protographer and LaTex.

Installing protographer:
```
go get -u github.com/protograph/protographer/cmd/protographer
```

Generating protograph:
```
set -e
protographer
for file in tex/*.tex
do
  docker run -v $(pwd)/tex:/tex --workdir /tex --rm --name latex yukinying/latex pdflatex --halt-on-error "/$file"
done

cd tex
find . -name '*.tex' -exec pdflatex -halt-on-error '{}' \;
```

Please see SCHEMA.md for how to write a protograph in YAML.
