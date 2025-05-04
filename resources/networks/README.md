# Terraform AWS Resources Provision Repository
This folder directory is for provisioning/destroying groups of AWS Network resources. The network resources include below:
  - VPC
  - Subnets
  - Internet Gateway
  - Nat Gateway
  - Elastic IP
  - Route table
  - Network ACL
  - VPC Endpoint

Usage instruction please refer to [README](../../README.md#Usage) file.

## GitHubAccessPolicy for network resources

<b> Please make sure you have replaced below in the policy document. </b>
  - <your_terraform_state_bucket_created_in_step_4>
  - <your_dynamo_db_table_created_in_step_5>
  - <your_account>

```
cat << EOF > github-actions-policy.json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:CreateVpc",
        "ec2:ModifyVpcAttribute",
        "ec2:DescribeVpcAttribute",
        "ec2:DeleteVpc",
        "ec2:DescribeVpcs",
        "ec2:CreateTags",
        "ec2:DeleteTags"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "ec2:CreateSubnet",
        "ec2:ModifySubnetAttribute",
        "ec2:DeleteSubnet",
        "ec2:DescribeSubnets",
        "ec2:CreateTags",
        "ec2:DeleteTags"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "ec2:CreateRouteTable",
        "ec2:CreateRoute",
        "ec2:DeleteRouteTable",
        "ec2:DeleteRoute",
        "ec2:AssociateRouteTable",
        "ec2:DisassociateRouteTable",
        "ec2:DescribeRouteTables",
        "ec2:CreateTags",
        "ec2:DeleteTags"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "ec2:CreateInternetGateway",
        "ec2:AttachInternetGateway",
        "ec2:DetachInternetGateway",
        "ec2:DeleteInternetGateway",
        "ec2:DescribeInternetGateways",
        "ec2:CreateTags",
        "ec2:DeleteTags"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "ec2:AllocateAddress",
        "ec2:ReleaseAddress",
        "ec2:DescribeAddresses",
        "ec2:DescribeAddressesAttribute",
        "ec2:CreateTags",
        "ec2:DeleteTags"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "ec2:CreateNatGateway",
        "ec2:DeleteNatGateway",
        "ec2:DescribeNatGateways",
        "ec2:CreateTags",
        "ec2:DeleteTags"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "ec2:CreateNetworkAcl",
        "ec2:CreateNetworkAclEntry",
        "ec2:DeleteNetworkAcl",
        "ec2:DeleteNetworkAclEntry",
        "ec2:ReplaceNetworkAclAssociation",
        "ec2:DescribeNetworkAcls",
        "ec2:DescribeNetworkInterfaces",
        "ec2:CreateTags",
        "ec2:DeleteTags"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "ec2:DescribeAvailabilityZones",
        "ec2:DescribeRegions",
        "ec2:DescribeAccountAttributes"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:DeleteObject",
        "s3:ListBucket"
      ],
      "Resource": [
        "arn:aws:s3:::<your_terraform_state_bucket_created_in_step_4>",
        "arn:aws:s3:::<your_terraform_state_bucket_created_in_step_4>/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "dynamodb:PutItem",
        "dynamodb:GetItem",
        "dynamodb:DeleteItem"
      ],
      "Resource": "arn:aws:dynamodb:ap-southeast-2:<your_account>:table/<your_dynamo_db_table_created_in_step_5>"
    }
  ]
}
EOF
```

## Succussful Provision job sample: 
https://github.com/hihinsonli/02Terraform-General-Resources/actions/runs/14819954868

### Sample Provision Terraform Plan Output

```
Terraform will perform the following actions:
  # module.eip.aws_eip.root will be created
  + resource "aws_eip" "root" {
      + allocation_id        = (known after apply)
      + arn                  = (known after apply)
      + association_id       = (known after apply)
      + carrier_ip           = (known after apply)
      + customer_owned_ip    = (known after apply)
      + domain               = "vpc"
      + id                   = (known after apply)
      + instance             = (known after apply)
      + ipam_pool_id         = (known after apply)
      + network_border_group = "ap-southeast-2"
      + network_interface    = (known after apply)
      + private_dns          = (known after apply)
      + private_ip           = (known after apply)
      + ptr_record           = (known after apply)
      + public_dns           = (known after apply)
      + public_ip            = (known after apply)
      + public_ipv4_pool     = "amazon"
      + tags                 = {
          + "Environment" = "dev"
          + "Name"        = "my-web-app-eip"
        }
      + tags_all             = {
          + "Environment" = "dev"
          + "Name"        = "my-web-app-eip"
        }
      + vpc                  = (known after apply)
    }
  # module.internet_gateway.aws_internet_gateway.root will be created
  + resource "aws_internet_gateway" "root" {
      + arn      = (known after apply)
      + id       = (known after apply)
      + owner_id = (known after apply)
      + tags     = {
          + "Environment" = "dev"
          + "Name"        = "my-web-app-internet-gateway"
        }
      + tags_all = {
          + "Environment" = "dev"
          + "Name"        = "my-web-app-internet-gateway"
        }
      + vpc_id   = (known after apply)
    }
  # module.nat_gateway.aws_nat_gateway.root will be created
  + resource "aws_nat_gateway" "root" {
      + allocation_id                      = (known after apply)
      + association_id                     = (known after apply)
      + connectivity_type                  = "public"
      + id                                 = (known after apply)
      + network_interface_id               = (known after apply)
      + private_ip                         = (known after apply)
      + public_ip                          = (known after apply)
      + secondary_private_ip_address_count = (known after apply)
      + secondary_private_ip_addresses     = (known after apply)
      + subnet_id                          = (known after apply)
      + tags                               = {
          + "Environment" = "dev"
          + "Name"        = "my-web-app-nat-gateway"
        }
      + tags_all                           = {
          + "Environment" = "dev"
          + "Name"        = "my-web-app-nat-gateway"
        }
    }
  # module.network_acl["private"].aws_network_acl.root will be created
  + resource "aws_network_acl" "root" {
      + arn        = (known after apply)
      + egress     = [
          + {
              + action          = "allow"
              + cidr_block      = "0.0.0.0/0"
              + from_port       = 0
              + ipv6_cidr_block = ""
              + protocol        = "-1"
              + rule_no         = 100
              + to_port         = 0
            },
        ]
      + id         = (known after apply)
      + ingress    = [
          + {
              + action          = "allow"
              + cidr_block      = "10.0.0.0/25"
              + from_port       = 443
              + ipv6_cidr_block = ""
              + protocol        = "tcp"
              + rule_no         = 110
              + to_port         = 443
            },
          + {
              + action          = "allow"
              + cidr_block      = "10.0.0.0/25"
              + from_port       = 8080
              + ipv6_cidr_block = ""
              + protocol        = "tcp"
              + rule_no         = 120
              + to_port         = 8080
            },
          + {
              + action          = "allow"
              + cidr_block      = "10.0.0.0/25"
              + from_port       = 80
              + ipv6_cidr_block = ""
              + protocol        = "tcp"
              + rule_no         = 100
              + to_port         = 80
            },
        ]
      + owner_id   = (known after apply)
      + subnet_ids = (known after apply)
      + tags       = {
          + "Environment" = "dev"
          + "Name"        = "my-web-app-private-network-acl-network-acl"
        }
      + tags_all   = {
          + "Environment" = "dev"
          + "Name"        = "my-web-app-private-network-acl-network-acl"
        }
      + vpc_id     = (known after apply)
    }
  # module.network_acl["public"].aws_network_acl.root will be created
  + resource "aws_network_acl" "root" {
      + arn        = (known after apply)
      + egress     = [
          + {
              + action          = "allow"
              + cidr_block      = "0.0.0.0/0"
              + from_port       = 0
              + ipv6_cidr_block = ""
              + protocol        = "-1"
              + rule_no         = 100
              + to_port         = 0
            },
        ]
      + id         = (known after apply)
      + ingress    = [
          + {
              + action          = "allow"
              + cidr_block      = "0.0.0.0/0"
              + from_port       = 0
              + ipv6_cidr_block = ""
              + protocol        = "-1"
              + rule_no         = 120
              + to_port         = 0
            },
          + {
              + action          = "deny"
              + cidr_block      = "0.0.0.0/0"
              + from_port       = 22
              + ipv6_cidr_block = ""
              + protocol        = "tcp"
              + rule_no         = 100
              + to_port         = 22
            },
          + {
              + action          = "deny"
              + cidr_block      = "0.0.0.0/0"
              + from_port       = 3389
              + ipv6_cidr_block = ""
              + protocol        = "tcp"
              + rule_no         = 110
              + to_port         = 3389
            },
        ]
      + owner_id   = (known after apply)
      + subnet_ids = (known after apply)
      + tags       = {
          + "Environment" = "dev"
          + "Name"        = "my-web-app-public-network-acl-network-acl"
        }
      + tags_all   = {
          + "Environment" = "dev"
          + "Name"        = "my-web-app-public-network-acl-network-acl"
        }
      + vpc_id     = (known after apply)
    }
  # module.route-table["private"].aws_route_table.root will be created
  + resource "aws_route_table" "root" {
      + arn              = (known after apply)
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + route            = [
          + {
              + carrier_gateway_id         = ""
              + cidr_block                 = "0.0.0.0/0"
              + core_network_arn           = ""
              + destination_prefix_list_id = ""
              + egress_only_gateway_id     = ""
              + gateway_id                 = ""
              + ipv6_cidr_block            = ""
              + local_gateway_id           = ""
              + nat_gateway_id             = (known after apply)
              + network_interface_id       = ""
              + transit_gateway_id         = ""
              + vpc_endpoint_id            = ""
              + vpc_peering_connection_id  = ""
            },
        ]
      + tags             = {
          + "Environment" = "dev"
          + "Name"        = "my-web-app-private-route-table-route-table"
        }
      + tags_all         = {
          + "Environment" = "dev"
          + "Name"        = "my-web-app-private-route-table-route-table"
        }
      + vpc_id           = (known after apply)
    }
  # module.route-table["private"].aws_route_table_association.subnet_route["private-2"] will be created
  + resource "aws_route_table_association" "subnet_route" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }
  # module.route-table["private"].aws_route_table_association.subnet_route["private-3"] will be created
  + resource "aws_route_table_association" "subnet_route" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }
  # module.route-table["public"].aws_route_table.root will be created
  + resource "aws_route_table" "root" {
      + arn              = (known after apply)
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + route            = [
          + {
              + carrier_gateway_id         = ""
              + cidr_block                 = "0.0.0.0/0"
              + core_network_arn           = ""
              + destination_prefix_list_id = ""
              + egress_only_gateway_id     = ""
              + gateway_id                 = (known after apply)
              + ipv6_cidr_block            = ""
              + local_gateway_id           = ""
              + nat_gateway_id             = ""
              + network_interface_id       = ""
              + transit_gateway_id         = ""
              + vpc_endpoint_id            = ""
              + vpc_peering_connection_id  = ""
            },
        ]
      + tags             = {
          + "Environment" = "dev"
          + "Name"        = "my-web-app-public-route-table-route-table"
        }
      + tags_all         = {
          + "Environment" = "dev"
          + "Name"        = "my-web-app-public-route-table-route-table"
        }
      + vpc_id           = (known after apply)
    }
  # module.route-table["public"].aws_route_table_association.subnet_route["public-0"] will be created
  + resource "aws_route_table_association" "subnet_route" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }
  # module.route-table["public"].aws_route_table_association.subnet_route["public-1"] will be created
  + resource "aws_route_table_association" "subnet_route" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }
  # module.subnets["10.0.0.0/26"].aws_subnet.root will be created
  + resource "aws_subnet" "root" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "ap-southeast-2a"
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "10.0.0.0/26"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = false
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + tags                                           = {
          + "Environment" = "dev"
          + "Name"        = "my-web-app-subnet-public-a-subnet"
        }
      + tags_all                                       = {
          + "Environment" = "dev"
          + "Name"        = "my-web-app-subnet-public-a-subnet"
        }
      + vpc_id                                         = (known after apply)
    }
  # module.subnets["10.0.0.128/26"].aws_subnet.root will be created
  + resource "aws_subnet" "root" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "ap-southeast-2a"
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "10.0.0.128/26"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = false
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + tags                                           = {
          + "Environment" = "dev"
          + "Name"        = "my-web-app-subnet-private-a-subnet"
        }
      + tags_all                                       = {
          + "Environment" = "dev"
          + "Name"        = "my-web-app-subnet-private-a-subnet"
        }
      + vpc_id                                         = (known after apply)
    }
  # module.subnets["10.0.0.192/26"].aws_subnet.root will be created
  + resource "aws_subnet" "root" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "ap-southeast-2b"
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "10.0.0.192/26"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = false
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + tags                                           = {
          + "Environment" = "dev"
          + "Name"        = "my-web-app-subnet-private-b-subnet"
        }
      + tags_all                                       = {
          + "Environment" = "dev"
          + "Name"        = "my-web-app-subnet-private-b-subnet"
        }
      + vpc_id                                         = (known after apply)
    }
  # module.subnets["10.0.0.64/26"].aws_subnet.root will be created
  + resource "aws_subnet" "root" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "ap-southeast-2b"
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "10.0.0.64/26"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = false
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + tags                                           = {
          + "Environment" = "dev"
          + "Name"        = "my-web-app-subnet-public-b-subnet"
        }
      + tags_all                                       = {
          + "Environment" = "dev"
          + "Name"        = "my-web-app-subnet-public-b-subnet"
        }
      + vpc_id                                         = (known after apply)
    }
  # module.vpc.aws_vpc.root will be created
  + resource "aws_vpc" "root" {
      + arn                                  = (known after apply)
      + assign_generated_ipv6_cidr_block     = true
      + cidr_block                           = "10.0.0.0/24"
      + default_network_acl_id               = (known after apply)
      + default_route_table_id               = (known after apply)
      + default_security_group_id            = (known after apply)
      + dhcp_options_id                      = (known after apply)
      + enable_dns_hostnames                 = true
      + enable_dns_support                   = true
      + enable_network_address_usage_metrics = false
      + id                                   = (known after apply)
      + instance_tenancy                     = "default"
      + ipv6_association_id                  = (known after apply)
      + ipv6_cidr_block                      = (known after apply)
      + ipv6_cidr_block_network_border_group = (known after apply)
      + main_route_table_id                  = (known after apply)
      + owner_id                             = (known after apply)
      + tags                                 = {
          + "Environment" = "dev"
          + "Name"        = "my-web-app-vpc"
        }
      + tags_all                             = {
          + "Environment" = "dev"
          + "Name"        = "my-web-app-vpc"
        }
    }
Plan: 16 to add, 0 to change, 0 to destroy.
```

## Succussful Destroy job sample: 
https://github.com/hihinsonli/02Terraform-General-Resources/actions/runs/14819994466

### Sample Destroy Terraform Plan Output

```
Terraform will perform the following actions:

  # module.eip.aws_eip.root will be destroyed
  - resource "aws_eip" "root" {
      - allocation_id        = "eipalloc-0d3bad78ef5c7ad0d" -> null
      - arn                  = "arn:aws:ec2:ap-southeast-2:154864927037:elastic-ip/eipalloc-0d3bad78ef5c7ad0d" -> null
      - association_id       = "eipassoc-088e8beb251b1a05f" -> null
      - domain               = "vpc" -> null
      - id                   = "eipalloc-0d3bad78ef5c7ad0d" -> null
      - network_border_group = "ap-southeast-2" -> null
      - network_interface    = "eni-0885a3f5c651ea22c" -> null
      - private_dns          = "ip-10-0-0-57.ap-southeast-2.compute.internal" -> null
      - private_ip           = "10.0.0.57" -> null
      - public_dns           = "ec2-13-236-197-128.ap-southeast-2.compute.amazonaws.com" -> null
      - public_ip            = "13.236.197.128" -> null
      - public_ipv4_pool     = "amazon" -> null
      - tags                 = {
          - "Environment" = "dev"
          - "Name"        = "my-web-app-eip"
        } -> null
      - tags_all             = {
          - "Environment" = "dev"
          - "Name"        = "my-web-app-eip"
        } -> null
      - vpc                  = true -> null
    }

  # module.internet_gateway.aws_internet_gateway.root will be destroyed
  - resource "aws_internet_gateway" "root" {
      - arn      = "arn:aws:ec2:ap-southeast-2:154864927037:internet-gateway/igw-0b7af39f109930414" -> null
      - id       = "igw-0b7af39f109930414" -> null
      - owner_id = "154864927037" -> null
      - tags     = {
          - "Environment" = "dev"
          - "Name"        = "my-web-app-internet-gateway"
        } -> null
      - tags_all = {
          - "Environment" = "dev"
          - "Name"        = "my-web-app-internet-gateway"
        } -> null
      - vpc_id   = "vpc-0e5784d09a7639436" -> null
    }

  # module.nat_gateway.aws_nat_gateway.root will be destroyed
  - resource "aws_nat_gateway" "root" {
      - allocation_id                      = "eipalloc-0d3bad78ef5c7ad0d" -> null
      - association_id                     = "eipassoc-088e8beb251b1a05f" -> null
      - connectivity_type                  = "public" -> null
      - id                                 = "nat-093f5901e18c0baf0" -> null
      - network_interface_id               = "eni-0885a3f5c651ea22c" -> null
      - private_ip                         = "10.0.0.57" -> null
      - public_ip                          = "13.236.197.128" -> null
      - secondary_allocation_ids           = [] -> null
      - secondary_private_ip_address_count = 0 -> null
      - secondary_private_ip_addresses     = [] -> null
      - subnet_id                          = "subnet-08ff0d904d968a034" -> null
      - tags                               = {
          - "Environment" = "dev"
          - "Name"        = "my-web-app-nat-gateway"
        } -> null
      - tags_all                           = {
          - "Environment" = "dev"
          - "Name"        = "my-web-app-nat-gateway"
        } -> null
    }

  # module.network_acl["private"].aws_network_acl.root will be destroyed
  - resource "aws_network_acl" "root" {
      - arn        = "arn:aws:ec2:ap-southeast-2:154864927037:network-acl/acl-056c8b93a3d07239e" -> null
      - egress     = [
          - {
              - action          = "allow"
              - cidr_block      = "0.0.0.0/0"
              - from_port       = 0
              - icmp_code       = 0
              - icmp_type       = 0
              - ipv6_cidr_block = ""
              - protocol        = "-1"
              - rule_no         = 100
              - to_port         = 0
            },
        ] -> null
      - id         = "acl-056c8b93a3d07239e" -> null
      - ingress    = [
          - {
              - action          = "allow"
              - cidr_block      = "10.0.0.0/25"
              - from_port       = 443
              - icmp_code       = 0
              - icmp_type       = 0
              - ipv6_cidr_block = ""
              - protocol        = "6"
              - rule_no         = 110
              - to_port         = 443
            },
          - {
              - action          = "allow"
              - cidr_block      = "10.0.0.0/25"
              - from_port       = 8080
              - icmp_code       = 0
              - icmp_type       = 0
              - ipv6_cidr_block = ""
              - protocol        = "6"
              - rule_no         = 120
              - to_port         = 8080
            },
          - {
              - action          = "allow"
              - cidr_block      = "10.0.0.0/25"
              - from_port       = 80
              - icmp_code       = 0
              - icmp_type       = 0
              - ipv6_cidr_block = ""
              - protocol        = "6"
              - rule_no         = 100
              - to_port         = 80
            },
        ] -> null
      - owner_id   = "154864927037" -> null
      - subnet_ids = [
          - "subnet-02d94b7cf78a82b2c",
          - "subnet-0781c0c378d90f558",
        ] -> null
      - tags       = {
          - "Environment" = "dev"
          - "Name"        = "my-web-app-private-network-acl-network-acl"
        } -> null
      - tags_all   = {
          - "Environment" = "dev"
          - "Name"        = "my-web-app-private-network-acl-network-acl"
        } -> null
      - vpc_id     = "vpc-0e5784d09a7639436" -> null
    }

  # module.network_acl["public"].aws_network_acl.root will be destroyed
  - resource "aws_network_acl" "root" {
      - arn        = "arn:aws:ec2:ap-southeast-2:154864927037:network-acl/acl-0882843e888eca09f" -> null
      - egress     = [
          - {
              - action          = "allow"
              - cidr_block      = "0.0.0.0/0"
              - from_port       = 0
              - icmp_code       = 0
              - icmp_type       = 0
              - ipv6_cidr_block = ""
              - protocol        = "-1"
              - rule_no         = 100
              - to_port         = 0
            },
        ] -> null
      - id         = "acl-0882843e888eca09f" -> null
      - ingress    = [
          - {
              - action          = "allow"
              - cidr_block      = "0.0.0.0/0"
              - from_port       = 0
              - icmp_code       = 0
              - icmp_type       = 0
              - ipv6_cidr_block = ""
              - protocol        = "-1"
              - rule_no         = 120
              - to_port         = 0
            },
          - {
              - action          = "deny"
              - cidr_block      = "0.0.0.0/0"
              - from_port       = 22
              - icmp_code       = 0
              - icmp_type       = 0
              - ipv6_cidr_block = ""
              - protocol        = "6"
              - rule_no         = 100
              - to_port         = 22
            },
          - {
              - action          = "deny"
              - cidr_block      = "0.0.0.0/0"
              - from_port       = 3389
              - icmp_code       = 0
              - icmp_type       = 0
              - ipv6_cidr_block = ""
              - protocol        = "6"
              - rule_no         = 110
              - to_port         = 3389
            },
        ] -> null
      - owner_id   = "154864927037" -> null
      - subnet_ids = [
          - "subnet-08ff0d904d968a034",
          - "subnet-0f61a837a7466539b",
        ] -> null
      - tags       = {
          - "Environment" = "dev"
          - "Name"        = "my-web-app-public-network-acl-network-acl"
        } -> null
      - tags_all   = {
          - "Environment" = "dev"
          - "Name"        = "my-web-app-public-network-acl-network-acl"
        } -> null
      - vpc_id     = "vpc-0e5784d09a7639436" -> null
    }

  # module.route-table["private"].aws_route_table.root will be destroyed
  - resource "aws_route_table" "root" {
      - arn              = "arn:aws:ec2:ap-southeast-2:154864927037:route-table/rtb-01984c461ce809566" -> null
      - id               = "rtb-01984c461ce809566" -> null
      - owner_id         = "154864927037" -> null
      - propagating_vgws = [] -> null
      - route            = [
          - {
              - carrier_gateway_id         = ""
              - cidr_block                 = "0.0.0.0/0"
              - core_network_arn           = ""
              - destination_prefix_list_id = ""
              - egress_only_gateway_id     = ""
              - gateway_id                 = ""
              - ipv6_cidr_block            = ""
              - local_gateway_id           = ""
              - nat_gateway_id             = "nat-093f5901e18c0baf0"
              - network_interface_id       = ""
              - transit_gateway_id         = ""
              - vpc_endpoint_id            = ""
              - vpc_peering_connection_id  = ""
            },
        ] -> null
      - tags             = {
          - "Environment" = "dev"
          - "Name"        = "my-web-app-private-route-table-route-table"
        } -> null
      - tags_all         = {
          - "Environment" = "dev"
          - "Name"        = "my-web-app-private-route-table-route-table"
        } -> null
      - vpc_id           = "vpc-0e5784d09a7639436" -> null
    }

  # module.route-table["private"].aws_route_table_association.subnet_route["private-2"] will be destroyed
  - resource "aws_route_table_association" "subnet_route" {
      - id             = "rtbassoc-030d7175e37f39bdb" -> null
      - route_table_id = "rtb-01984c461ce809566" -> null
      - subnet_id      = "subnet-02d94b7cf78a82b2c" -> null
    }

  # module.route-table["private"].aws_route_table_association.subnet_route["private-3"] will be destroyed
  - resource "aws_route_table_association" "subnet_route" {
      - id             = "rtbassoc-0c884a6d76cd85ff1" -> null
      - route_table_id = "rtb-01984c461ce809566" -> null
      - subnet_id      = "subnet-0781c0c378d90f558" -> null
    }

  # module.route-table["public"].aws_route_table.root will be destroyed
  - resource "aws_route_table" "root" {
      - arn              = "arn:aws:ec2:ap-southeast-2:154864927037:route-table/rtb-0e71b5c6ddaea0a70" -> null
      - id               = "rtb-0e71b5c6ddaea0a70" -> null
      - owner_id         = "154864927037" -> null
      - propagating_vgws = [] -> null
      - route            = [
          - {
              - carrier_gateway_id         = ""
              - cidr_block                 = "0.0.0.0/0"
              - core_network_arn           = ""
              - destination_prefix_list_id = ""
              - egress_only_gateway_id     = ""
              - gateway_id                 = "igw-0b7af39f109930414"
              - ipv6_cidr_block            = ""
              - local_gateway_id           = ""
              - nat_gateway_id             = ""
              - network_interface_id       = ""
              - transit_gateway_id         = ""
              - vpc_endpoint_id            = ""
              - vpc_peering_connection_id  = ""
            },
        ] -> null
      - tags             = {
          - "Environment" = "dev"
          - "Name"        = "my-web-app-public-route-table-route-table"
        } -> null
      - tags_all         = {
          - "Environment" = "dev"
          - "Name"        = "my-web-app-public-route-table-route-table"
        } -> null
      - vpc_id           = "vpc-0e5784d09a7639436" -> null
    }

  # module.route-table["public"].aws_route_table_association.subnet_route["public-0"] will be destroyed
  - resource "aws_route_table_association" "subnet_route" {
      - id             = "rtbassoc-0052933a885e4dce7" -> null
      - route_table_id = "rtb-0e71b5c6ddaea0a70" -> null
      - subnet_id      = "subnet-08ff0d904d968a034" -> null
    }

  # module.route-table["public"].aws_route_table_association.subnet_route["public-1"] will be destroyed
  - resource "aws_route_table_association" "subnet_route" {
      - id             = "rtbassoc-0b61276af19cb6bac" -> null
      - route_table_id = "rtb-0e71b5c6ddaea0a70" -> null
      - subnet_id      = "subnet-0f61a837a7466539b" -> null
    }

  # module.subnets["10.0.0.0/26"].aws_subnet.root will be destroyed
  - resource "aws_subnet" "root" {
      - arn                                            = "arn:aws:ec2:ap-southeast-2:154864927037:subnet/subnet-08ff0d904d968a034" -> null
      - assign_ipv6_address_on_creation                = false -> null
      - availability_zone                              = "ap-southeast-2a" -> null
      - availability_zone_id                           = "apse2-az1" -> null
      - cidr_block                                     = "10.0.0.0/26" -> null
      - enable_dns64                                   = false -> null
      - enable_lni_at_device_index                     = 0 -> null
      - enable_resource_name_dns_a_record_on_launch    = false -> null
      - enable_resource_name_dns_aaaa_record_on_launch = false -> null
      - id                                             = "subnet-08ff0d904d968a034" -> null
      - ipv6_native                                    = false -> null
      - map_customer_owned_ip_on_launch                = false -> null
      - map_public_ip_on_launch                        = false -> null
      - owner_id                                       = "154864927037" -> null
      - private_dns_hostname_type_on_launch            = "ip-name" -> null
      - tags                                           = {
          - "Environment" = "dev"
          - "Name"        = "my-web-app-subnet-public-a-subnet"
        } -> null
      - tags_all                                       = {
          - "Environment" = "dev"
          - "Name"        = "my-web-app-subnet-public-a-subnet"
        } -> null
      - vpc_id                                         = "vpc-0e5784d09a7639436" -> null
    }

  # module.subnets["10.0.0.128/26"].aws_subnet.root will be destroyed
  - resource "aws_subnet" "root" {
      - arn                                            = "arn:aws:ec2:ap-southeast-2:154864927037:subnet/subnet-02d94b7cf78a82b2c" -> null
      - assign_ipv6_address_on_creation                = false -> null
      - availability_zone                              = "ap-southeast-2a" -> null
      - availability_zone_id                           = "apse2-az1" -> null
      - cidr_block                                     = "10.0.0.128/26" -> null
      - enable_dns64                                   = false -> null
      - enable_lni_at_device_index                     = 0 -> null
      - enable_resource_name_dns_a_record_on_launch    = false -> null
      - enable_resource_name_dns_aaaa_record_on_launch = false -> null
      - id                                             = "subnet-02d94b7cf78a82b2c" -> null
      - ipv6_native                                    = false -> null
      - map_customer_owned_ip_on_launch                = false -> null
      - map_public_ip_on_launch                        = false -> null
      - owner_id                                       = "154864927037" -> null
      - private_dns_hostname_type_on_launch            = "ip-name" -> null
      - tags                                           = {
          - "Environment" = "dev"
          - "Name"        = "my-web-app-subnet-private-a-subnet"
        } -> null
      - tags_all                                       = {
          - "Environment" = "dev"
          - "Name"        = "my-web-app-subnet-private-a-subnet"
        } -> null
      - vpc_id                                         = "vpc-0e5784d09a7639436" -> null
    }

  # module.subnets["10.0.0.192/26"].aws_subnet.root will be destroyed
  - resource "aws_subnet" "root" {
      - arn                                            = "arn:aws:ec2:ap-southeast-2:154864927037:subnet/subnet-0781c0c378d90f558" -> null
      - assign_ipv6_address_on_creation                = false -> null
      - availability_zone                              = "ap-southeast-2b" -> null
      - availability_zone_id                           = "apse2-az3" -> null
      - cidr_block                                     = "10.0.0.192/26" -> null
      - enable_dns64                                   = false -> null
      - enable_lni_at_device_index                     = 0 -> null
      - enable_resource_name_dns_a_record_on_launch    = false -> null
      - enable_resource_name_dns_aaaa_record_on_launch = false -> null
      - id                                             = "subnet-0781c0c378d90f558" -> null
      - ipv6_native                                    = false -> null
      - map_customer_owned_ip_on_launch                = false -> null
      - map_public_ip_on_launch                        = false -> null
      - owner_id                                       = "154864927037" -> null
      - private_dns_hostname_type_on_launch            = "ip-name" -> null
      - tags                                           = {
          - "Environment" = "dev"
          - "Name"        = "my-web-app-subnet-private-b-subnet"
        } -> null
      - tags_all                                       = {
          - "Environment" = "dev"
          - "Name"        = "my-web-app-subnet-private-b-subnet"
        } -> null
      - vpc_id                                         = "vpc-0e5784d09a7639436" -> null
    }

  # module.subnets["10.0.0.64/26"].aws_subnet.root will be destroyed
  - resource "aws_subnet" "root" {
      - arn                                            = "arn:aws:ec2:ap-southeast-2:154864927037:subnet/subnet-0f61a837a7466539b" -> null
      - assign_ipv6_address_on_creation                = false -> null
      - availability_zone                              = "ap-southeast-2b" -> null
      - availability_zone_id                           = "apse2-az3" -> null
      - cidr_block                                     = "10.0.0.64/26" -> null
      - enable_dns64                                   = false -> null
      - enable_lni_at_device_index                     = 0 -> null
      - enable_resource_name_dns_a_record_on_launch    = false -> null
      - enable_resource_name_dns_aaaa_record_on_launch = false -> null
      - id                                             = "subnet-0f61a837a7466539b" -> null
      - ipv6_native                                    = false -> null
      - map_customer_owned_ip_on_launch                = false -> null
      - map_public_ip_on_launch                        = false -> null
      - owner_id                                       = "154864927037" -> null
      - private_dns_hostname_type_on_launch            = "ip-name" -> null
      - tags                                           = {
          - "Environment" = "dev"
          - "Name"        = "my-web-app-subnet-public-b-subnet"
        } -> null
      - tags_all                                       = {
          - "Environment" = "dev"
          - "Name"        = "my-web-app-subnet-public-b-subnet"
        } -> null
      - vpc_id                                         = "vpc-0e5784d09a7639436" -> null
    }

  # module.vpc.aws_vpc.root will be destroyed
  - resource "aws_vpc" "root" {
      - arn                                  = "arn:aws:ec2:ap-southeast-2:154864927037:vpc/vpc-0e5784d09a7639436" -> null
      - assign_generated_ipv6_cidr_block     = true -> null
      - cidr_block                           = "10.0.0.0/24" -> null
      - default_network_acl_id               = "acl-0839f8992152a2ea6" -> null
      - default_route_table_id               = "rtb-01e6881e140324274" -> null
      - dhcp_options_id                      = "dopt-0c1ae25aa9cd20c6e" -> null
      - enable_dns_hostnames                 = true -> null
      - enable_dns_support                   = true -> null
      - enable_network_address_usage_metrics = false -> null
      - id                                   = "vpc-0e5784d09a7639436" -> null
      - instance_tenancy                     = "default" -> null
      - ipv6_association_id                  = "vpc-cidr-assoc-053c6ba2d5163781a" -> null
      - ipv6_cidr_block                      = "2406:da1c:2d5:e300::/56" -> null
      - ipv6_cidr_block_network_border_group = "ap-southeast-2" -> null
      - ipv6_netmask_length                  = 0 -> null
      - main_route_table_id                  = "rtb-01e6881e140324274" -> null
      - owner_id                             = "154864927037" -> null
      - tags                                 = {
          - "Environment" = "dev"
          - "Name"        = "my-web-app-vpc"
        } -> null
      - tags_all                             = {
          - "Environment" = "dev"
          - "Name"        = "my-web-app-vpc"
        } -> null
    }

Plan: 0 to add, 0 to change, 16 to destroy.
```