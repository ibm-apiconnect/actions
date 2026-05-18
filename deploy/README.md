# API Connect Deploy Action

Deploy API projects to IBM API Connect catalogs using the API Connect Toolkit.

## Usage

```yaml
- uses: ibm-apiconnect/actions/deploy@v12
  with:
    manager-host: {{ manager hostname }}
    api-host: {{ platform api hostname }}
    provider-org: {{ provider org name }}
    catalog: {{ catalog name }}
    apikey: {{ API Connect apikey }}
    project-path: {{ product path within repo }}
    project: {{ name of project to publish }}
```

## Complete Example

Here's a complete workflow example (fully working example with [APIC on AWS](https://register.automation.ibm.com/apic/trial/aws?source=github-action-repo) available in the [test-apic-deploy repo](https://github.com/rickymoorhouse/test-apic-deploy/)):

```yaml
name: Deploy to API Connect

on: [push]

jobs:
  apic-deploy:
    runs-on: ubuntu-latest
    name: APIC Deployment
    steps:
      - uses: actions/checkout@v2
      - uses: ibm-apiconnect/actions/deploy@v12
        with:
          manager-host: ${{ secrets.APIC_MANAGER_HOST }}
          api-host: ${{ secrets.APIC_API_HOST }}
          provider-org: ${{ secrets.APIC_PROVIDER_ORG }}
          catalog: ${{ secrets.APIC_CATALOG }}
          apikey: ${{ secrets.APIC_APIKEY }}
          project-path: .
          project: my-api-project
```

## Parameters

The following parameters are always required:

 - manager-host - The hostname for API Manager
 - api-host - The hostname for the Platform API
 - provider-org - The provider org to use. 
 - catalog - The name of the catalog to publish the API into
 - project-path - The path to the folder within the repo containing API Projects
 - project - The name of the project to publish (use --all for all projects)

Authentication options - you will need one of these sets, depending on your API Connect deployment

 - apikey - An API Key obtained from {manager-host}/manager/auth/manager/sign-in/?from=TOOLKIT (typically used with an OIDC user registry e.g. in APIC on AWS)
 - username / password / realm - the username, password and realm to use to authenticate (typically used with a local user registry or LDAP)
 - iam-apikey - An IBM Cloud API Key (for use with reserved instance)

