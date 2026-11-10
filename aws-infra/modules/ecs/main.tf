resource "aws_ecs_cluster" "game_2048" {
  name = var.cluster_name
  tags = var.tags
}

resource "aws_ecs_task_definition" "game_2048" {
  family                   = var.family_name
  requires_compatibilities = var.requires_compatibilities
  network_mode             = var.network_mode
  execution_role_arn       = var.taskexecution_role_arn
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  container_definitions = jsonencode([
    {
      name      = var.container_name
      image     = var.container_image
      cpu       = var.container_cpu
      memory    = var.container_memory
      essential = var.essential
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_host_port
        }
      ]

       logConfiguration = {
        logDriver = "awslogs"

        options = {
          "awslogs-group"         =  var.log_group_name
          "awslogs-region"        =  var.aws_region
          "awslogs-stream-prefix" =  var.log_stream_prefix
        }
      }
    },

  ])
  tags = var.tags

}

resource "aws_ecs_service" "game_2048" {
  name                               = var.service_name
  cluster                            = aws_ecs_cluster.game_2048.id
  task_definition                    = aws_ecs_task_definition.game_2048.arn
  desired_count                      = 0
  launch_type                        = var.launch_type
  health_check_grace_period_seconds  = var.health_check_grace_period_seconds
  deployment_maximum_percent         = var.deployment_maximum_percent
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  availability_zone_rebalancing      = "ENABLED"

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

  network_configuration {
    assign_public_ip = var.assign_public_ip
    security_groups  = [var.ecs_sg]
    subnets          = var.subnets

  }

  deployment_controller {
    type = "ECS"
  }
  
  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

  lifecycle {
    ignore_changes = [
      task_definition,
      desired_count
    ]
  }

  

  tags = var.tags

}

