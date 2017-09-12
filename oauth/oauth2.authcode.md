# OAuth 2.0 Auth Code mode

## Actors 

U: Resource Owner
UA: User Agent
C: Client
AS: AuthZ Server
S: Resource Server

## Flows

### U sends UA
Initiate OAuth 2.0 flow

### UA sends C (color=blue)
Initiate OAuth 2.0 flow

### C sends UA (color=blue)
302 AuthServer:
CLIENTID, CLIENTURL, SCOPE, CLIENTSTATE

### UA sends AS (color=red)
POST /auth:
CLIENTID, CLIENTURL, SCOPE, CLIENTSTATE

### AS and U exchange messages about (color=red)
prompt to login and ask for consent

### AS sends UA (color=red)
302 CLIENTURL:
AUTHCODE, CLIENTSTATE

### UA sends C (color=blue) 
POST /cb:
AUTHCODE, CLIENTSTATE

### C sends AS (color=purple) 
POST /token
AUTHCODE, CLIENTURL, CLIENTID

### AS sends C (color=purple) 
200 OK:
ACCESSTOKEN

### C sends UA
Done

### UA sends U
Done

### C sends S
GET /resource 
ACCESSTOKEN

### S sends C
Here is the resources...