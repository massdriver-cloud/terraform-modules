# terraform-modules

Terraform modules used by Massdriver bundles

## Organization

Modules should be placed under a top level directory for the cloud they provision resources for (`aws`, `azure` or `gcp`), or under `massdriver` if they are specific to Massdriver. Cloud based modules should be usable outside of Massdriver as a standard community terraform module. Modules within `massdriver` should be specific to to Massdriver, but can reference and use modules from the cloud directories as needed.

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
