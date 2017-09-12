# OAuth 2.0 Implicit mode

## Notes
Implicit mode is optimized for browser based
clients or applications on mobile devices.

## Actors
U: Resource Owner
UA: User Agent
C: Client
AS: AuthZ Server

## Flows

### U sends C (color=blue)
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
ACCESSTOKEN (in URL Fragment), CLIENTSTATE

### UA sends C  (color=blue)
ACCESSTOKEN, CLIENTSTATE
