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
    arrow: <message label>
    from: <annotation for sender>
    to: <annotation for recipient>
```

As an example, DH key exchange could be described using format 1 as follows:
```
title: DH
actor:
-  A: Alice
-  B: Bob
sequence:
- A: {B: "$g$, $p$, $g^a$ mod $p$"}
- B: {A: $g^b$ mod $p$"}
```

Or using format 2 (with annotation in sender and recipient) as follows:
```
title: DH
actor:
-  A: Alice
-  B: Bob
sequence:
- A:
    B:
      arrow: "$g$, $p$, A"
      from: "$A = g^a$ mod $p$"
      to: "$B = g^b$ mod $p$"

# YAML in abbreviated form also works
- B: { A: { arrow: "$B$", from: "$K = A^b$ mod $p$", to: "$K = B^a$ mod $p$"}}
```
