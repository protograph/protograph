# Whatsapp Signal Protocol

## Notes
  
Notation: $(d, Q) <- `Curve25519()`$ is the key

generation function that generates $d$ as

private key and $Q$ as public key.

## Actors
I: initiator: $a$
S: server
R: recipient: $b$

## Expressions
I: `I`
S: `S`
O: `O`
E: `E`

## Flows

### I computes
    Identity Key: I_a = (d_{I_a}, Q_{I_a})  <- Curve25519()
    Signed Pre Key: S_a = (d_{S_a}, Q_{S_a}) <- Curve25519()
    `One-Time` Pre Key: O_a = (d_{O_a}, Q_{O_a})<- Curve25519()

### I sends S
    Q_{I_a}, Q_{S_a}, Q_{O_a}, Sign_{d_{I_a}}(Q_{S_a})

### R computes
    Identity Key: I_b = (d_{I_b}, Q_{I_b})  <- Curve25519()
    Signed Pre Key: S_b = (d_{S_b}, Q_{S_b}) <- Curve25519()
    `One-Time` Pre Key: O_b = (d_{O_b}, Q_{O_b})<- Curve25519()

### R sends S
    Q_{I_b}, Q_{S_b}, Q_{O_b}, Sign_{d_{I_b}}(Q_{S_b})

### I sends S
get recipient public keys

### S sends I
    Q_{I_b}, Q_{S_b}, Q_{O_b}

### I computes
    Ephemeral Key: E_a = (d_{E_a}, Q_{E_a})<- Curve25519()

### I sends R
    Q_{I_a}, Q_{E_a}

### I computes 
    Exchange K_1

### I and R exchange messages about
    ECDH(I_a, S_b)

### Then R computes 
    Exchange K_1

### I computes 
    Exchange K_2

### I and R exchange messages about
    ECDH(E_a, I_b)

### Then R computes 
    Exchange K_2

### I computes 
    Exchange K_3

### I and R exchange messages about
    ECDH(E_a, S_b)

### Then R computes 
    Exchange K_3

### I computes 
    Exchange K_4

### I and R exchange messages about
    ECDH(E_a, O_b)

### Then R computes 
    Exchange K_4

### I thinks
    K_master <- K_1 || K_2 || K_3 || K_4 
    K_root, K_chain = HKDF(K_master)

### I computes
    Ephemeral Key: E_a = (d_{E_a}, Q_{E_a})<- Curve25519()
    K_message = HMAC_{K_chain}(1) 
    K_chain = HMAC_{K_chain}(2) 
    cipher = Encrypt_{K_message}(message)
    signature = HMAC_{K_message}(cipher)

### I sends R (padtop=1)
    cipher, signature, Q_{E_a}

### Then R computes
    K_master <- K_1 || K_2 || K_3 || K_4 
    K_root, K_chain = HKDF(K_master)
    K_message = HMAC_{K_chain}(1) 
    K_chain = HMAC_{K_chain}(2) 
    message = Decrypt_{K_message}(cipher)

### I thinks (padtop=1)
Keep sending new messages until recipient responds.

### R computes
    Ephemeral Key: E_b = (d_{E_b}, Q_{E_b})<- Curve25519()

### R sends I
    Q_{E_b}

### I computes 
    Exchange K_ephemeral
    K_chain, K_root = HKDF(K_root, K_ephemeral)

### I and R exchange messages about
    ECDH(E_a, E_b)

### Then R computes
    Exchange K_ephemeral
    K_chain, K_root = HKDF(K_root, K_ephemeral)

### I thinks (padtop=1)
As $K_chain$ and $K_root$ are rolled,
the rest of the protocol follows from above.

