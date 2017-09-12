# Sigma Protocol

SIGMA: the ‘SIGn-and-MAc’ Approach to Authenticated Diffie-Hellman and its Use in the IKE Protocols

## Actors

A: Alice
B: Bob

## Flows

### A sends B

$g^x$

### B sends A

$g^y, B, `SIG`_B(g^x, g^y), `MAC`_{K_m}(B)$

### A sends B

$A, `SIG`_A(g^y, g^x), `MAC`_{K_m}(A)$

## Notes 

Sigma protocol is defined in http://webee.technion.ac.il/~hugo/sigma-pdf.pdf p17 