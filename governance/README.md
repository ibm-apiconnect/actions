# API Connect Governance Action

Validate API specifications against governance rulesets and compliance requirements using the API Connect Toolkit.

## Usage

```yaml
- uses: ibm-apiconnect/actions/governance@v12
  with:
    manager-host: {{ manager hostname }}
    api-host: {{ platform api hostname }}
    provider-org: {{ provider org name }}
    apikey: {{ API Connect apikey }}
    api-spec: {{ api specification file }}
```

## Complete Example

Here's a complete workflow example for validating APIs on pull requests:

```yaml
name: API Governance Check

on: [pull_request]

jobs:
  validate-api:
    runs-on: ubuntu-latest
    name: Validate API Compliance
    steps:
      - uses: actions/checkout@v2
      - uses: ibm-apiconnect/actions/governance@v12
        with:
          manager-host: ${{ secrets.APIC_MANAGER_HOST }}
          api-host: ${{ secrets.APIC_API_HOST }}
          provider-org: ${{ secrets.APIC_PROVIDER_ORG }}
          apikey: ${{ secrets.APIC_APIKEY }}
          api-spec: api.yaml
```

## Parameters

### Required Parameters

- **manager-host** - The hostname for API Manager
- **api-host** - The hostname for the Platform API
- **provider-org** - The provider organization to use
- **api-spec** - The path to the API specification file to validate (default: `api.yaml`)

### Authentication Options

You must provide one of these authentication methods:

- **apikey** - An API Key obtained from `{manager-host}/manager/auth/manager/sign-in/?from=TOOLKIT` (typically used with an OIDC user registry, e.g., in APIC on AWS)
- **username** / **password** / **realm** - Username, password, and realm to authenticate (typically used with a local user registry or LDAP)
- **iam-apikey** - An IBM Cloud API Key (for use with reserved instance)

## How It Works

This action:

1. Downloads the API Connect Toolkit from your API Manager
2. Authenticates using your provided credentials
3. Validates your API specification against configured governance rulesets
4. Reports compliance errors and warnings as GitHub annotations
5. Fails the workflow if critical errors are found

The validation results are displayed directly in your pull request or workflow run, making it easy to identify and fix compliance issues before deployment.

## Related Actions

- [Deploy Action](../deploy/README.md) - Deploy API projects to catalogs
- [Testing Action](../testing/README.md) - Run automated tests against APIs

