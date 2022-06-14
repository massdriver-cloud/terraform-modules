# terraform-modules

Terraform modules used by Massdriver bundles
## Development

### Enabling Pre-commit

This repo includes Terraform pre-commit hooks.

[Install precommmit](https://pre-commit.com/index.html#installation) on your system.

```shell
git init
pre-commit install
```

Terraform hooks will now be run on each commit.

You'll additionally need to install:

* [Terrascan](https://github.com/tenable/terrascan)
* [Terraform Docs](https://github.com/terraform-docs/terraform-docs)
