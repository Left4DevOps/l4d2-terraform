#!/bin/bash
# shellcheck disable=SC2154
aws s3 sync "s3://${BUCKET}" /home/ec2-user/
echo "ECS_CLUSTER=${CLUSTER}" >> /etc/ecs/ecs.config