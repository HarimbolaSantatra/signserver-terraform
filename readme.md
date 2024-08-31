# QUICK TERRAFORM DEPLOYMENT OF SIGNSERVER 

For the API, [as described in the documentation](https://doc.primekey.com/signserver/signserver-integration/rest-interface#RESTInterface-CustomHeaderrequires),
the custom header *X-Keyfactor-Requested-With* is required for admin operations.

Nginx use the custom header using value from [the only reference I found](https://software.keyfactor.com/Core-OnPrem/Current/Content/WebAPI/AuthenticateAPI.htm).

All API endpoint are available on the [OpenAPI document](https://doc.primekey.com/signserver/files/100415/100418/2/1701701198381/openapi.json).

## Setup

    terraform apply -var-file=secret.tfvars
