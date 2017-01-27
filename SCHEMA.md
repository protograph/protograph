# Protograph Schema

Protographs are generated from YAML file. The YAML file has the following schema (with UPPERCASE word denoting the type of data):

```
title: TITLE

actor:
- ACTOR_ID: ACTOR_NAME
- ACTOR_ID: ACTOR_NAME
...

sequence:
# format 1
- SENDER_ID: { RECEIVER_ID: MESSAGE }
- SENDER_ID: { RECEIVER_ID: MESSAGE }
...
# format 2
- SENDER_ID:
  RECEIVER_ID:
    arrow: MESSAGE
    from: ANNOTATION_AT_SENDER_SIDE
    to: ANNOTATION_AT_RECEIVER_SIDE
    time: DELAY_TIME
...
# format 3 (insert emptyline. Use reserved word EMPTYLINE)
- EMPTYLINE:
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
      time: 1

- EMPTYLINE

# YAML in abbreviated form also works
- B: { A: { arrow: "$B$", from: "$K = A^b$ mod $p$", to: "$K = B^a$ mod $p$", time: 1}}
```
