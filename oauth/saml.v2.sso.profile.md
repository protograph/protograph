# SAML v2 Authentication Request (Web Browser SSO Profile)

## Actors
U: User / Browser
SP: Service Provider
IP: Identity Provider

## Flows

### U sends SP
HTTPS GET https://SP/resource
from the Service Provider

### Then SP computes
The SP identifies that the $SubjectID$
is coming from a preconfigured
Identity Provider

### SP computes
Generate the $SAMLRequest$
and $RelayState$

### SP sends U (padtop=1)
Return an XHTML form
with $SAMLRequest$,
$RelayState$

### U sends IP (padtop=1)
HTTPS POST https://IP/SAML2/SSO/POST
$SAMLRequest$, $RelayState$

### Then IP computes
Associate the $SAMLRequest$ and $RelayState$
with $SubjectID$

### IP sends U
Authentication flow between $SubjectID$

### U sends IP
Successful authentication of $SubjectID$

### IP sends U (padtop=1)
Return an XHTML form
with $SAMLResponse$,
$RelayState$

### U sends SP 
HTTPS POST https://SP/SMAL2/SSO/POST
with $SAMLResponse$, $RelayState$

### Then SP computes
Assertion of the $SAMLResponse$
 and $RelayState$

### SP sends U
HTTPS 302 Redirect to https://SP/resource