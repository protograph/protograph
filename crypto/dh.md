# Diffie Hellman Key Exchange

Diffie Hellman key exchange is a method to exchange keys over a public channel.

## Actors

A: Alice
B: Bob

## Flows

### A computes

    A = g^a mod p

### A sends B (delay=1)

    g, p, A

### Then B computes

    B = g^b mod p

### B computes

    K = A^b mod p

### B sends A (delay=1)

    B

### Then A computes

    K = B^a mod p

## Notes

## Output

* [LaTeX](dh.tex)
* [PDF](dh.pdf)
