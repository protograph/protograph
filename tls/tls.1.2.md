# TLS 1.2

## Actors
C: Client
S: Server

## Flows

### C computes
ClientHello

### C sends S
version, timestamp, random, session,
cipher suites, compression methods,
extensions (signature algorithms)

### S computes
ServerHello

### S sends C (padtop=1)
version, timestamp, random, session,
cipher suites, compression methods,
extensions

### S computes
Certificate. OPTIONAL

### S sends C (padtop=1)
list of certificate

### S computes
ServerKeyExchange. OPTIONAL
(for DHE_DSS, DHE_RSA or DH_anon)

### S sends C (padtop=1)
DH parameters ($p, g, g^x ` mod ` p)$, signature

### S computes
CertificateRequest. OPTIONAL

### S sends C (padtop=1)
acceptable certificate type,
signature and hash algorithms,
certificate authorities

### S computes
ServerHelloDone

### S sends C 

### C sends S
Certificate*

### C sends S
ClientKeyExchange

### C sends S
CertificateVerify*

### C sends S
[ChangeCipherSpec]

### C sends S
Finished

### S sends C
[ChangeCipherSpec]

### S sends C
Finished

### C and S exchange messages about 
Application Data
