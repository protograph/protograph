# UAF Authentication & Transaction

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
User clicks on any action required authentication on https://webapp?purchase

### B sends W
HTTP GET https://webapp?purchase

### W sends S
Start UAF Authentication/Transaction Request

### Then S computes
Generate
CHALLENGE ($c$),
Auth Policy ($p$),
and Transaction Text ($t$)

$t$ is present in transaction
confirmation ONLY.

### S sends W
Send UAF Authentication/Transaction Request = ($c$, $p$, $t$)

### W sends B
HTTP 200 OK ($a$ = APP_ID, $c$, $p$, $t$)

### B sends C
$a$, $c$, $p$, $t$

### Then C computes
Obtain the TLS_DATA

### C sends W
Get FACET_ID by $a$

### W sends C
Return list of FACET_ID(s)

### C computes
1. Select authenticator(s) according to $p$
2. Lookup the key handle ($h$) and access key ($ak$)
3. $fcp$ = ($a$, $c$, FACET_ID, TLS_DATA)"

### C sends ASM
$h$, $ak$, $t$, $fc$ = hash($fcp$), ...

### ASM sends A (padtop=1)
Send Sign Command
($h$, $ak$, $t$, $fc$, ...)

### A sends U
Trigger local user verification

### U sends A
User Verified

### Then A computes
1. Unlock UAuth Key Pair = ($Auth.pub$, $Auth.priv$) for this handle $h$ by $ak$
2. Generate a nonce ($n$)
3. Generate the Sign Data = $SignData$ = ($fc$, $n$, $cntr$, $t$, $sig$ = signature_by_$Auth.priv$($fc$, $n$, $cntr$, $t$))
$cntr$ = Signature Counter.

### A sends ASM (padtop=1)
    SignData

### ASM sends C
    SignData

### C sends B
    SignData

### B sends W
    SignData

### W sends S
    SignData

### Then S computes
1. Verify the $SignData$ signature by $Auth.pub$

### S sends W
Return verification result

### W sends B
HTTP 200 OK (verification result) and session binding