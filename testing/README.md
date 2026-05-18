# API Connect Testing Action

Run automated tests against your API projects using the API Connect Toolkit.

## Usage

```yaml
- uses: ibm-apiconnect/actions/testing@v12
  with:
    manager-host: {{ manager hostname }}
    api-host: {{ platform api hostname }}
    provider-org: {{ provider org name }}
    apikey: {{ API Connect apikey }}
    project-path: {{ product path within repo }}
    project: {{ name of project to test }}
    test-endpoint: {{ endpoint to test against }}
    test-name: {{ name of test to run }}
```

## Complete Example

Here's a complete workflow example for running API tests:

```yaml
name: API Testing

on: [push, pull_request]

jobs:
  test-api:
    runs-on: ubuntu-latest
    name: Run API Tests
    steps:
      - uses: actions/checkout@v2
      - uses: ibm-apiconnect/actions/testing@v12
        with:
          manager-host: ${{ secrets.APIC_MANAGER_HOST }}
          api-host: ${{ secrets.APIC_API_HOST }}
          provider-org: ${{ secrets.APIC_PROVIDER_ORG }}
          apikey: ${{ secrets.APIC_APIKEY }}
          project-path: .
          project: my-api-project
          test-endpoint: https://api-sandbox.example.com
          test-name: integration-tests
```

## Parameters

### Required Parameters

- **manager-host** - The hostname for API Manager
- **api-host** - The hostname for the Platform API
- **provider-org** - The provider organization to use
- **project-path** - The path to the folder within the repo containing API Projects (default: `.`)
- **project** - The name of the project to test (default: `project`)
- **test-endpoint** - The endpoint URL to run tests against
- **test-name** - The name of the test suite to run

### Authentication Options

You must provide one of these authentication methods:

- **apikey** - An API Key obtained from `{manager-host}/manager/auth/manager/sign-in/?from=TOOLKIT` (typically used with an OIDC user registry, e.g., in APIC on AWS)
- **username** / **password** / **realm** - Username, password, and realm to authenticate (typically used with a local user registry or LDAP)
- **iam-apikey** - An IBM Cloud API Key (for use with reserved instance)

## How It Works

This action:

1. Downloads the API Connect Toolkit from your API Manager
2. Authenticates using your provided credentials
3. Runs the specified test suite against your API project
4. Parses test results and creates GitHub annotations for failures
5. Reports test summary (passed/failed counts)
6. Fails the workflow if any tests fail

Test results are displayed as annotations in your pull request or workflow run, making it easy to identify and fix issues.

## Related Actions

- [Deploy Action](../deploy/README.md) - Deploy API projects to catalogs
- [Governance Action](../governance/README.md) - Validate API specifications against governance rules