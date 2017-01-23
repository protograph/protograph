# Protograph

Protograph is a collection of sequence diagrams of various protocols.

Protograph generations requires protographer and LaTex.

Installing protographer:
```
go get github.com/protograph/protographer/cmd/protographer
```

Generating protograph:
```
protographer -in yaml -out tex
cd tex
find . -name '*.tex' -exec pdflatex -halt-on-error '{}' \;
```

Please see SCHEMA.md for how to write a protograph in YAML.
