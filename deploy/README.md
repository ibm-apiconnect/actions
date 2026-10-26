# API Connect Deploy Action

Deploy API projects to IBM API Connect catalogs using the REST API.

## Usage

```yaml
- uses: ibm-apiconnect/actions/deploy@v12
  with:
    api-host: ${{ secrets.APIC_API_HOST }}
    client-id: ${{ secrets.APIC_CLIENT_ID }}
    client-secret: ${{ secrets.APIC_CLIENT_SECRET }}
    provider-org: ${{ secrets.APIC_PROVIDER_ORG }}
    catalog: ${{ secrets.APIC_CATALOG }}
    apikey: ${{ secrets.APIC_APIKEY }}
    project-path: .
    project: my-api-project
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
          api-host: ${{ secrets.APIC_API_HOST }}
          client-id: ${{ secrets.APIC_CLIENT_ID }}
          client-secret: ${{ secrets.APIC_CLIENT_SECRET }}
          provider-org: ${{ secrets.APIC_PROVIDER_ORG }}
          catalog: ${{ secrets.APIC_CATALOG }}
          apikey: ${{ secrets.APIC_APIKEY }}
          project-path: .
          project: my-api-project
```

## Parameters

The following parameters are always required:

 - **api-host** - The hostname for the Platform API
 - **client-id** - Toolkit client ID (see [Finding your credentials](#finding-your-credentials))
 - **client-secret** - Toolkit client secret (see [Finding your credentials](#finding-your-credentials))
 - **provider-org** - The provider org to use
 - **catalog** - The name of the catalog to publish the API into
 - **project-path** - The path to the folder within the repo containing API projects
 - **project** - The name of the project to publish

Authentication options — you will need one of these sets, depending on your API Connect deployment:

 - **apikey** - A platform API key generated from **My account > API keys** in API Manager (typically used with OIDC users, e.g. APIC on AWS)
 - **username** / **password** / **realm** - Username, password, and realm (typically used with a local user registry or LDAP)

## Finding Your Credentials

The `client-id` and `client-secret` come from the **toolkit credentials file** (`credentials.json`) that API Manager generates alongside the toolkit download.

To obtain them:

1. Log in to API Manager (`https://<manager-host>/manager`)
2. Click **Download toolkit** from the home page
3. Download `credentials.json` from the same dialog — it contains a `toolkit` section with `client_id` and `client_secret`

The values look like:

```json
{
  "toolkit": {
    "client_id": "599b7aef-8841-4ee2-88a0-84d49c4d6ff2",
    "client_secret": "0ea28423-e73b-47d4-b40e-ddb45c48bb0c"
  }
}
```

> **Important:** Store these as [GitHub Actions secrets](https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions) — never commit them to your repository. Add them as `APIC_CLIENT_ID` and `APIC_CLIENT_SECRET` in your repository's **Settings > Secrets and variables > Actions**.

