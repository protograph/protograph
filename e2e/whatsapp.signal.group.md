# Whatsapp Signal Protocol

## Expressions
S: `S`

## Actors
I: sender: $a$
S: server
R: recipients

## Flows

### I computes
    K_chain <- Random_{32{bytes}}()
    S_a = (d_{S_a}, Q_{S_a}) <- Curve25519()
    K_sender =  K_chain || Q_{S_a}

### I sends R
sends $K_sender$ using the pairwise messaging protocol

### I computes
    K_message = HMAC_{K_chain}(1) 
    K_chain = HMAC_{K_chain}(2) 
    cipher = Encrypt_{K_message}(message)
    signature = Sign_{d_{S_a}}(cipher)

### I sends S (padtop=1)
cipher, signature

### S sends R
cipher, signature