# tf_aws_route53 [WIP]

## Module to create DNS structure on Route53.

This terraform module will create the DNS structure you need.
The module has several submodules, so you can choose the DNS architecture you need.

This module is [WIP].

## Public Domain

Create a DNS domain in R53 as public hosted zone with serveral subdomain for each environment.

### Inputs

  * domain
  * environments  default = { "pre,dev" }
  
### Outputs

  * zone_id
  * environment_zone_ids
  * environment_names
  
### Example Use

```
# Define Public Domains
module "r53_public" {
  source = "github.com/koesystems/tf_aws_route53"
  domain = "r53test.com"
}
```
  
## Private Domain

Create a private domain (related with a VPC) for each environment

### Inputs

  * region
  * domain
  * public_zone_id
  * environments default = { "pro,pre,dev" }
  * vpc_ids

### Outputs

  * zone_ids
  * environments_names
  
### Example Use

  ```
  # Define Private Domains
  module "r53_private" {
    source = "github.com/koesystems/tf_aws_route53"
    domain = "r53test.com"
    public_zone_id = "${module.r53_public.zone_id}"
    region = "${var.region}"
    environments = "pro,pre,dev"
    vpc_ids = "${format("%s,%s,%s", module.vpc01.vpc_id, module.vpc02.vpc_id, module.vpc03.vpc_id)}"
  }
  ```

# LICENSE

Apache2, see the included LICENSE file for more information.
