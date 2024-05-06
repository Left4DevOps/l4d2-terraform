# Left 4 DevOps ECS Cluster
 
Creates an autoscaling group which can be used to temporarily host Left 4 Dead and Left 4 Dead 2. SSM enabled for remote
access. Upload custom content to the included s3 bucket which will be synced on boot.

## Variables

### Required

* `aws_region` - Region used to deploy resources
* `key_name` - Key pair used for remote access

### Optional

* `name` - name of resources
* `log_rotation` - number of days to keep logs, defaults to 7 days
* `volume_size` - root volume size in GB, defaults to 30GB
* `vpc_id` - VPC used to deploy resources. If not specified, will use first VPC.
* `subnet_ids` - List of subnets within VPC to deploy server.  If not specified, will use all within VPC.

## Outputs

* `cluster_name`
* `log_group_name`
* `security_group_id`