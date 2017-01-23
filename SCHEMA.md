# Protograph Schema

Protographs are generated from YAML file. The YAML file has the following schema:

```
title: <title>

actor:
- <actor abbreviation>: <actor name>
- <actor abbreviation>: <actor name>
...

sequence:
- (format 1)<(sender) actor abbreviation>: {<(recipient) actor abbreviation>: <message label>}
- (format 1)<(sender) actor abbreviation>: {<(recipient) actor abbreviation>: <message label>}
...
- (format 2)<(sender) actor abbreviation>:
  <(recipient) actor abbreviation>:
    label: <message label>
    textFrom: <annotation for sender>
    textTo: <annotation for recipient>
```

As an example, DH key exchange could be described as:
```
title: DH
actor:
-  A: Alice
-  B: Bob
sequence:
- A:
    B:
      label: "$g$, $p$, A"
      textFrom: "$A = g^a$ mod $p$"
      textTo: "$B = g^b$ mod $p$"

- B:
    A:
      label: "$B$"
      textFrom: "$K = A^b$ mod $p$"
      textTo: "$K = B^a$ mod $p$"
```

or as simple as
```
title: DH
actor:
-  A: Alice
-  B: Bob
sequence:
- A: {B: "$g$, $p$, $g^a$ mod $p$"
- B: {A: $g^b$ mod $p$"}
```
