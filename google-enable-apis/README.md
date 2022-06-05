# terraform-google-enable-apis

This module takes a list of Google Cloud APIs and then will wait a variable amount of time for the APIs to be live. API enablement in GCP is asynchronous. If a Terraform workspace enables an API then tries to use that resource, this will often produce an error because the API is not yet live.
