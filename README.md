# IBM API Connect GitHub Actions

This repository contains reusable GitHub Actions for IBM API Connect, enabling you to automate API deployment, governance validation, and testing using the API Connect Toolkit. Originally based on [this blog post](https://community.ibm.com/community/user/integration/blogs/ricky-moorhouse1/2021/03/16/whats-new-use-the-api-connect-toolkit-with-github).

## Available Actions

This repository provides three specialized actions for different API Connect workflows:

### 1. Deploy Action (`ibm-apiconnect/actions/deploy@v12`)

Deploy API projects to IBM API Connect catalogs.

**Example usage:**
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

[View detailed deploy documentation →](deploy/README.md)

### 2. Governance Action (`ibm-apiconnect/actions/governance@v12`)

Validate API specifications against governance rulesets and compliance requirements.

**Example usage:**
```yaml
- uses: ibm-apiconnect/actions/governance@v12
  with:
    manager-host: {{ manager hostname }}
    api-host: {{ platform api hostname }}
    provider-org: {{ provider org name }}
    apikey: {{ API Connect apikey }}
    api-spec: api.yaml
```

[View detailed governance documentation →](governance/README.md)

### 3. Testing Action (`ibm-apiconnect/actions/testing@v12`)

Run automated tests against your API projects.

**Example usage:**
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

## Complete Workflow Example

Here's an example workflow that uses all three actions together:

```yaml
name: API Connect CI/CD

on: [push, pull_request]

jobs:
  validate:
    runs-on: ubuntu-latest
    name: Validate API Governance
    steps:
      - uses: actions/checkout@v2
      - uses: ibm-apiconnect/actions/governance@v12
        with:
          manager-host: ${{ secrets.APIC_MANAGER_HOST }}
          api-host: ${{ secrets.APIC_API_HOST }}
          provider-org: ${{ secrets.APIC_PROVIDER_ORG }}
          apikey: ${{ secrets.APIC_APIKEY }}
          api-spec: api.yaml

  test:
    runs-on: ubuntu-latest
    name: Test API
    needs: validate
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
          test-endpoint: https://api.example.com
          test-name: integration-tests

  deploy:
    runs-on: ubuntu-latest
    name: Deploy API
    needs: test
    if: github.ref == 'refs/heads/main'
    steps:
      - uses: actions/checkout@v2
      - uses: ibm-apiconnect/actions/deploy@v12
        with:
          manager-host: ${{ secrets.APIC_MANAGER_HOST }}
          api-host: ${{ secrets.APIC_API_HOST }}
          provider-org: ${{ secrets.APIC_PROVIDER_ORG }}
          catalog: production
          apikey: ${{ secrets.APIC_APIKEY }}
          project-path: .
          project: my-api-project
```

## Common Parameters

All actions share these common authentication parameters:

### Required Parameters
- **manager-host** - The hostname for API Manager
- **api-host** - The hostname for the Platform API
- **provider-org** - The provider organization to use

### Authentication Options

You must provide one of these authentication methods, depending on your API Connect deployment:

- **apikey** - An API Key obtained from `{manager-host}/manager/auth/manager/sign-in/?from=TOOLKIT` (typically used with an OIDC user registry, e.g., in APIC on AWS)
- **username** / **password** / **realm** - Username, password, and realm to authenticate (typically used with a local user registry or LDAP)
- **iam-apikey** - An IBM Cloud API Key (for use with reserved instance)

## Getting Started

1. Try the [APIC on AWS free trial](https://register.automation.ibm.com/apic/trial/aws?source=github-action-repo)
2. Check out the [test-apic-deploy repository](https://github.com/rickymoorhouse/test-apic-deploy/) for a fully working example
3. Review the individual action documentation for specific parameters and usage

## Resources

- [IBM API Connect Documentation](https://www.ibm.com/docs/en/api-connect)
- [API Connect Toolkit CLI Reference](https://www.ibm.com/docs/en/api-connect/10.0.x?topic=configuration-toolkit-command-line-tool)
- [Original Blog Post](https://community.ibm.com/community/user/integration/blogs/ricky-moorhouse1/2021/03/16/whats-new-use-the-api-connect-toolkit-with-github)

