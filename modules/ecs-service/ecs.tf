resource "aws_ecs_service" "app" {
  name                               = local.name
  task_definition                    = aws_ecs_task_definition.app.arn
  cluster                            = var.cluster
  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent         = 100
  desired_count                      = 1

  deployment_circuit_breaker {
    enable   = false
    rollback = false
  }

  tags = {
    game         = local.long_game_name
    port         = var.port
    net_con_port = local.net_con_port
  }

  lifecycle {
    ignore_changes = [desired_count]
  }
}

resource "aws_ecs_task_definition" "app" {
  family       = local.long_game_name
  network_mode = "host"

  volume {
    name      = "addons"
    host_path = var.addon_path == "" ? "/home/ec2-user/${local.long_game_name}/addons/" : var.addon_path
  }

  container_definitions = jsonencode(
    [
      {
        name   = local.long_game_name
        image  = "${var.registry}/${var.game}:${var.docker_tag}"
        cpu    = var.cpu
        memory = var.memory
        logConfiguration = {
          logDriver = "awslogs"
          options = {
            awslogs-group         = var.log_group_name
            awslogs-region        = "eu-west-2"
            awslogs-stream-prefix = tostring(var.port)
          }
        }
        mountPoints = [
          {
            sourceVolume  = "addons"
            containerPath = "/addons/"
          },
        ]
        environment = [
          {
            name  = "HOSTNAME"
            value = var.hostname
          },
          {
            name  = "REGION"
            value = tostring(var.region)
          },
          {
            name  = "STEAM_GROUP"
            value = tostring(var.steam_group)
          },
          {
            name  = "STEAM_GROUP_EXCLUSIVE"
            value = var.steam_group_exclusive != "" ? tostring(var.steam_group_exclusive) : ""
          },
          {
            name  = "PORT"
            value = tostring(var.port)
          },
          {
            name  = "DEFAULT_MODE"
            value = var.default_mode
          },
          {
            name  = "RCON_PASSWORD"
            value = var.rcon_password
          },
          {
            name  = "NET_CON_PORT"
            value = tostring(local.net_con_port)
          },
          {
            name  = "NET_CON_PASSWORD"
            value = var.net_con_password
          },
          {
            name  = "EXTRA_ARGS"
            value = var.extra_args
          },
        ]
      }
    ]
  )
}