# Re-usable API Connect deployment action 

This repo contains the re-usable API Connect action to deploy an API using the API Connect Toolkit originally based on [this blog post](https://community.ibm.com/community/user/integration/blogs/ricky-moorhouse1/2021/03/16/whats-new-use-the-api-connect-toolkit-with-github). 

For a simple example you can configure your action to publish a specific product yaml from your github repository with something like this (fully working example with [APIC on AWS](https://register.automation.ibm.com/apic/trial/aws?source=github-action-repo) available in my [test-apic-deploy repo](https://github.com/rickymoorhouse/test-apic-deploy/): 

```
on: [push]

jobs:
  apic-deploy-test:
    runs-on: ubuntu-latest
    name: APIC deployment
    steps:
    - uses: actions/checkout@v2
    - uses: ibm-apiconnect/apic-deploy@main
      with:
        manager-host: {{ manager hostname }}
        api-host:  {{ platform api hostname }}
        provider-org: {{ provider org name }}
        catalog: {{ catalog name }}
        apikey: {{ API Connect apikey }}
        product-file: {{ product file to publish }}
```

## Parameters

The following parameters are always required:

 - manager-host - The hostname for API Manager
 - api-host - The hostname for the Platform API
 - provider-org - The provider org to use. 
 - catalog - The name of the catalog to publish the API into
 - product-file - The path to the product yaml within your git repo

Authentication options - you will need one of these sets, depending on your API Connect deployment

 - apikey - An API Key obtained from {manager-host}/manager/auth/manager/sign-in/?from=TOOLKIT (typically used with an OIDC user registry e.g. in APIC on AWS)
 - username / password / realm - the username, password and realm to use to authenticate (typically used with a local user registry or LDAP)
 - iam-apikey - An IBM Cloud API Key (for use with reserved instance)

### Validate API definitions

If you just want to validate your apis and products, then you can pass the variable `validate_only: true` without any authentication option.  This is useful for a PR check. The default is false. 

### Migrate Subscriptions

If you need to ensure the subscriptions remain in place when publishing you can pass `migrate_subscription: true` as a parameter.  This is useful in development so that you can configure your tests without having to re-subscribe to the APIs every time but shouldn't be a substitution for proper API versioning and lifecycle management in a production environment. The default is false.  

