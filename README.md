# Re-usable API Connect deployment action 

Based on my blog post on building a continuous deployment set up for your API with GitHub actions to automate the API publishing when you push a new commit to your git repo.  I’ve extended this to create a re-usable action that anyone can use within their GitHub Actions – simply point to it in the steps like this:

```
on: [push]

jobs:
  apic-deploy-test:
    runs-on: ubuntu-latest
    name: APIC deployment
    steps:
    - uses: actions/checkout@v2
    - uses: rickymoorhouse/apic-deploy@main
      with:
        manager-host: {{ manager hostname }}
        api-host:  {{ platform api hostname }}
        provider-org: {{ provider org name }}
        catalog: {{ catalog name }}
        iam-apikey: {{ IBM Cloud IAM apikey }}
        product-file: {{ product file to publish }}
```


