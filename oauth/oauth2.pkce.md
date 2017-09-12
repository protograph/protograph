# OAuth 2.0 Proof Key for Code Exchange (PKCE)

## Actors
U: Resource Owner
UA: User Agent
C: Client
AS: Authz Server
S: Resource Server

## Flows

### C computes
VERIFIER = SECURE_RNG() 
CHALLENGE = SHA256(VERIFIER)

### C sends UA
302 AuthServer: 
CLIENTID, CLIENTURL, SCOPE, CLIENTSTATE,
 CHALLENGE

### UA sends AS
POST /auth 
 CLIENTID, CLIENTURL, SCOPE, CLIENTSTATE, CHALLENGE

### AS sends U
prompt to login

### U sends AS
signing in

### AS sends U
asking for consent

### U sends AS
yes!

### AS sends UA
302 CLIENTURL: 
AUTHCODE, CLIENTSTATE

### UA sends C
POST /cb 
AUTHCODE, CLIENTSTATE

### C sends AS
AUTHCODE, VERIFIER

### Then AS computes
CHALLENGE $\stackrel{?}{=}$ SHA256(VERIFIER)

### AS sends C
200 OK: 
ACCESSTOKEN
