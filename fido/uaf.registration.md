# UAF Registration

## Actors
U: User
A: Authenticator
ASM: Authenticator Specific Modules
C: FIDO Client
B: User Agent
W: Web Server
S: FIDO Server


## Flows

### U sends B
User clicks on https://webapp

### B sends W
HTTP GET https://webapp

### W sends B
HTTP 200 OK (login form returns)

### B sends U
Render the login form

### U sends B
User enters $u$ = USERNAME, $pwd$ = PASMSWORD
and submits

### B sends W
HTTP POST {$u$, $pwd$}
 
### Then W computes
Verify $u$, $pwd$

### W sends S 
Start UAF Registration

### Then S computes
Generate Auth Policy ($p$)

### S sends W
Send UAF Registration Request = 
($a$ = APP_ID, $c$ = CHALLENGE, $u$, $p$)

### W sends B
HTTP 200 OK ($a$, $u$, $c$, $p$)

### B sends C
    a, u, c, p
    
### Then C computes
1. Obtain the TLS_DATA

### C sends W
Get FACET_ID by $a$

### W sends C
Return list of FACET_ID(s)

### C computes
1. Select authenticator(s) according to $p$
2. $fcp$ = ($a$, $c$, FACET_ID, TLS_DATA)

### C sends ASM
    a, u, fc = hash(fcp)

### Then ASM computes
1. Generate the access token
$ak$ = hash($a$, NONCE, PERSONA_ID, CALLER_ID)
CALLER_ID is the platform ID assigned to the FIDO Client
PERSONA_ID is the user ID on the platform

### ASM sends A (padtop=1)
Send Register Command
($a$, $u$, $ak$, $fc$)

### A sends U
Trigger local user verification

### U sends A (padtop=1)
User interacts with Authenticator(s)

### Then A computes
1. Generate UAuth Key Pair = ($Auth.pub$, $Auth.priv$) for this handle $h$ = ($a$, $u$) by $ak$
2. Generate the Key Registration Data = $KRD$ = ($AAID$, $h$, $Auth.pub$, $fc$, $Att.cert$, $reg-cntr$, $cntr$, $sig$ = signature_by_$Att.priv$($AAID$, $Auth.pub$, $fc$, $Att.pub$, $reg-cntr$, $cntr$))
$AAID$ = Authenticator Attestation ID
$Att.cert$ = Authenticator Certificate
$Att.pub$, $Att.priv$ = Authenticator Key Pair
$reg-cntr$ = Registration Counter
$cntr$ = Signature Counter

### A sends ASM (padtop=1)
    KRD

### ASM sends C
    KRD
    
### C sends B
    KRD
    
### B sends W
    KRD
    
### W sends S
    KRD

### Then S computes
1. Verify the $KRD$ signature by $Att.pub$
2. Store $Auth.pub$ for this $h$

### S sends W
Return verification result

### W sends B
HTTP 200 OK (verification result)