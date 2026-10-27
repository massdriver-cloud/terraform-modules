# terraform-modules

Terraform modules used by Massdriver bundles

## Organization

Modules should be placed under a top level directory for the cloud they provision resources for (`aws`, `azure` or `gcp`), or under `massdriver` if they are specific to Massdriver. Cloud based modules should be usable outside of Massdriver as a standard community terraform module. Modules within `massdriver` should be specific to to Massdriver, but can reference and use modules from the cloud directories as needed.

## Deprecated Modules

The cloud alarm modules below are deprecated and will be removed from this repository. Use the official modules instead:

| Deprecated module | Replacement |
|---|---|
| `aws/cloudwatch-alarm` | [terraform-massdriver-aws-metric-alarm](https://github.com/massdriver-cloud/terraform-massdriver-aws-metric-alarm) |
| `aws/cloudwatch-alarm-expression` | [terraform-massdriver-aws-metric-alarm](https://github.com/massdriver-cloud/terraform-massdriver-aws-metric-alarm) |
| `aws/alarm-channel` | [terraform-massdriver-aws-alarm-channel](https://github.com/massdriver-cloud/terraform-massdriver-aws-alarm-channel) |
| `azure/monitor-metrics-alarm` | [terraform-massdriver-azure-metric-alarm](https://github.com/massdriver-cloud/terraform-massdriver-azure-metric-alarm) |
| `azure/alarm-channel` | [terraform-massdriver-azure-alarm-channel](https://github.com/massdriver-cloud/terraform-massdriver-azure-alarm-channel) |
| `gcp-metric-alarm` | [terraform-massdriver-gcp-metric-alarm](https://github.com/massdriver-cloud/terraform-massdriver-gcp-metric-alarm) |
| `gcp/alarm-channel` | [terraform-massdriver-gcp-alarm-channel](https://github.com/massdriver-cloud/terraform-massdriver-gcp-alarm-channel) |

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
