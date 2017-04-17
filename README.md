Route53 terraform module
========================

A terraform module to create hosted zone with AWS Route53.

Module Input Variables
----------------------

- `domain_name`

Usage examples
-----

```js
module "r53" {
  source  = "github.com/KoeSystems/tf_aws_route53"
  domain_name = "domain.localdomain"
}
```

Outputs
=======

- `domain_name`
- `primary_public_zone_id`

Costs
=====

This module will create 1 public hosted zones in AWS Route53.

Authors
=======

Originally created and maintained by [Koe](https://github.com/KoeSystems)

License
=======

MIT License. See LICENSE for full details.