# TLS 1.3 Simplified

## Config
separation: 12

## Expressions
CA: `CA`
ID: `ID`
IV: `IV`
a: `a`
b: `b`

## Notes

Disclaimer: this diagram is a rough sketch of the TLS 1.3 handshake and record protocol. It serves as a quickstarter to understand the protocol flows. It may contain inaccurate or oversimplified representations. 

1) TLS Settings

Cipher Suite: TLS_AES_128_GCM_SHA256

Digital Signature: ecdsa_secp256r1_sha256

Key Exchange: secp256r1 (NIST P-256) with $(G, n)$ as part of domain parameters, with public and private key in the form of $(Q, d)$

Pre-Shared Key Cipher: TLS_ECDHE_PSK_WITH_AES_256_CBC_SHA384

2) Protocol Notations

Key Extraction Function: Extract(salt, keying material)

Key Derive Function: Derive(secret, label, transcript), where transcript is the concatenation of each included handshake message.

Encryption: \{plaintext\}$_{`key`}$, which denotes an AEAD-Encrypt operation with write key and IV generated from key.

## Actors

C: Client (a)

S: Server (b)

## Flows

### C computes
    r_a \xleftarrow{random} \{0,1\}^{256}
    Ephermal key: Q_a <- d_a{G}

### C sends S
    ClientHello: r_a
    KeyShare: Q_a

### S computes
    S_early <- Extract(0, 0)
    r_b \xleftarrow{random} \{0,1\}^{256}
    Ephermal key: Q_b <- d_b{G}
    Key exchanged via ECDHE: x <- (x, y) = d_a Q_b

### S sends C
    ServerHello: r_b
    KeyShare: Q_b

### S thinks (padtop=1)
    S_handshake <- Extract(Derive(S_early, `'derived'`, \emptyset), x)
    S_master <- Extract(Derive(S_handshake,`'derived'`, \emptyset), 0)

### S computes 
    Handshake traffic key: K_{handshake_b} <- Derive(S_handshake, `'s\ hs\ traffic'`, transcript)

### S sends C (padtop=1)
    \{Certificate: Public key with CA signature\}_{K_{handshake_b}}

### Then C computes
    Handshake traffic key: K_{handshake_a} <- Derive(S_handshake, `'c\ hs\ traffic'`, transcript)

### S sends C
    \{CertificateVerify: Transcript with ECDSA signature\}_{K_{handshake_b}}

### S computes 
    Finished key: K_finished <- Derive(K_{handshake_b}, `'finished'`, transcript)

### S sends C 
    \{Finished: HMAC(K_finished, transcript)\}_{K_{handshake_b}}

### C computes 
    Finished key: K_finished <- Derive(K_{handshake_a}, `'finished'`, transcript)

### C sends S
    \{Finished: HMAC(K_finished, transcript)\}_{K_{handshake_a}}

### Then S computes
    S_resumption <- Derive(S_master, `'res\ master'`, transcript)

### S computes
    Application traffic key: K_{b_0} <- Derive(S_master, `'s\ ap\ traffic'`, transcript)

### S sends C
    \{Application Data\}_{K_{b_0}}

### C computes
    Application traffic key: K_{a_0} <- Derive(S_master, `'c\ ap\ traffic'`, transcript)

### C sends S
    \{Application Data\}_{K_{a_0}}

### S computes
Creates a pre-shared key (PSK) binding to enable session resumption

### S sends C
    NewSessionTicket: \{session key `ID`, `IV`, encrypted state, HMAC(...)\}_{K_{b_0}}

### C and S exchange messages about (color=red, line=dashed)
(Connections terminated. That triggers session resumption with 0-RTT)

### C computes
    S_early <- Extract(0, S_resumption)
    Binder key: K_{binder} <- Derive(S_early, `'res\ binder'`, \emptyset)
    Early Traffic Key: K_{early} <- Derive(S_early, `'c\ e\ traffic'`, transcript)
    Finished key: K_finished <- Derive(K_{binder}, `'finished'`, transcript)

### C sends S (padtop=2)

ClientHello: ...

KeyShare: ...

PskKeyExchangeModes: 'psk_dhe_ke'

EarlyDataIndication

PreSharedKey: \{session key ID, HMAC($K_finished$, transcript)\}

\{Application Data\}$_{K_{early}}$

### S computes
    S_handshake <- Extract(Derive(S_early, `'derived'`, \emptyset), x)
    Handshake traffic key: K_{handshake_b} <- Derive(S_handshake, `'s\ hs\ traffic'`, transcript)

### S sends C (padtop=1)

ServerHello: ...

KeyShare: ...

PreSharedKey: \{session key ID\}

EncryptedExtensions: \{EarlyDataIndication\}$_{K_{handshake_b}}$

### S thinks
    S_master <- Extract(Derive(S_handshake,`'derived'`, \emptyset), 0)

### S computes
    Finished key: K_finished <- Derive(K_{handshake_b}, `'finished'`, transcript)

### S sends C
    \{Finished: HMAC(K_finished, transcript)\}_{K_{handshake_b}}

### S computes
    Application traffic key: K_{b_0} <- Derive(S_master, `'s\ ap\ traffic'`, transcript)

### S sends C
    \{Application Data\}_{K_{b_0}}

### C sends S
    \{EndOfEarlyData\}_{K_{early}}

### C computes
    Finished key: K_finished <- Derive(K_{handshake_a}, `'finished'`, transcript)

### C sends S
    \{Finished: HMAC(K_finished, transcript)\}_{K_{handshake_a}}

### S sends C
    \{Application Data\}_{K_{b_0}}

### C computes
    Application traffic key: K_{a_0} <- Derive(S_master, `'c\ ap\ traffic'`, transcript)

### C sends S
    \{Application Data\}_{K_{a_0}}
