An s3 bucket to use as a terraform backend.

- Versioning is enabled.
- public-access-block is enabled.
- SSE-KMS encryption by dedicated Key.
- Rejects transfers other than under SSL.

## example

```tf
module "terraform_backend" {
  source      = "github.com/moajo/terraform-backend-s3-bucket.git?ref=v2.0.0"
  bucket_name = "projecthogehoge-terraform-backend" # Must be a globally unique bucket name
}
```

<!-- BEGIN_TF_DOCS -->

## Requirements

| Name                                                   | Version |
| ------------------------------------------------------ | ------- |
| <a name="requirement_aws"></a> [aws](#requirement_aws) | ~> 4.0  |

## Providers

| Name                                             | Version |
| ------------------------------------------------ | ------- |
| <a name="provider_aws"></a> [aws](#provider_aws) | ~> 4.0  |

## Modules

No modules.

## Resources

| Name                                                                                                                                                                                  | Type        |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [aws_kms_alias.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias)                                                                           | resource    |
| [aws_kms_key.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key)                                                                               | resource    |
| [aws_s3_bucket.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)                                                                           | resource    |
| [aws_s3_bucket_acl.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl)                                                                   | resource    |
| [aws_s3_bucket_policy.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy)                                                             | resource    |
| [aws_s3_bucket_public_access_block.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block)                                   | resource    |
| [aws_s3_bucket_server_side_encryption_configuration.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource    |
| [aws_s3_bucket_versioning.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning)                                                     | resource    |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity)                                                         | data source |

## Inputs

| Name                                                               | Description           | Type     | Default | Required |
| ------------------------------------------------------------------ | --------------------- | -------- | ------- | :------: |
| <a name="input_bucket_name"></a> [bucket_name](#input_bucket_name) | Name of the s3 bucket | `string` | n/a     |   yes    |

## Outputs

| Name                                                     | Description                                |
| -------------------------------------------------------- | ------------------------------------------ |
| <a name="output_bucket"></a> [bucket](#output_bucket)    | Created aws_s3_bucket.                     |
| <a name="output_kms_key"></a> [kms_key](#output_kms_key) | Created aws_kms_key to encrypt the bucket. |

<!-- END_TF_DOCS -->
