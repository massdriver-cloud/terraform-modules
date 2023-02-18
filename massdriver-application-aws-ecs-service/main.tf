locals {
  vpc_id             = element(split("/", var.ecs_cluster.data.infrastructure.vpc.data.infrastructure.arn), 1)
  private_subnet_ids = toset([for subnet in var.ecs_cluster.data.infrastructure.vpc.data.infrastructure.private_subnets : element(split("/", subnet["arn"]), 1)])
  ecs_cluster_arn    = var.ecs_cluster.data.infrastructure.arn
}

module "application" {
  source  = "github.com/massdriver-cloud/terraform-modules//massdriver-application?ref=fc5f7b1"
  name    = var.md_metadata.name_prefix
  service = "function"
}

resource "aws_ecs_service" "main" {
  name            = var.md_metadata.name_prefix
  cluster         = local.ecs_cluster_arn
  task_definition = aws_ecs_task_definition.main.arn
  desired_count   = 1

  network_configuration {
    subnets         = local.private_subnet_ids
    security_groups = [aws_security_group.service.id]
  }

  #   ordered_placement_strategy {
  #     type  = "binpack"
  #     field = "cpu"
  #   }

  dynamic "load_balancer" {
    for_each = local.container_ingress_port_map
    content {
      target_group_arn = aws_lb_target_group.service[load_balancer.key].arn
      container_name   = load_balancer.value.container_name
      container_port   = load_balancer.value.container_port
    }
  }
}

resource "aws_ecs_task_definition" "main" {
  family = var.md_metadata.name_prefix
  //execution_role_arn       = var.ecs_task_execution_role_arn
  //requires_compatibilities = ["FARGATE"]
  network_mode = "awsvpc"
  #   memory                   = 512
  #   cpu                      = 256


  //task_role_arn   = module.application.id

  container_definitions = jsonencode(
    [for container in var.containers :
      {
        name      = container.name
        image     = "${container.image_repository}:${container.image_tag}"
        cpu       = container.cpu
        memory    = container.memory
        essential = true
        portMappings = [for port in container.ports :
          {
            containerPort = port.container_port
          }
        ]

        #   logConfiguration = {
        #     logDriver = "awslogs"
        #     options   = {
        #       awslogs-group         = "${lower(each.value["name"])}-logs"
        #       awslogs-region        = var.region
        #       awslogs-stream-prefix = var.app_name
        #     }
        #   }
      }
  ])
}

# resource "aws_appautoscaling_target" "service_autoscaling" {
#   for_each           = var.service_config
#   max_capacity       = each.value.auto_scaling.max_capacity
#   min_capacity       = each.value.auto_scaling.min_capacity
#   resource_id        = "service/${aws_ecs_cluster.ecs_cluster.name}/${aws_ecs_service.private_service[each.key].name}"
#   scalable_dimension = "ecs:service:DesiredCount"
#   service_namespace  = "ecs"
# }

# resource "aws_appautoscaling_policy" "ecs_policy_memory" {
#   for_each           = var.service_config
#   name               = "${var.app_name}-memory-autoscaling"
#   policy_type        = "TargetTrackingScaling"
#   resource_id        = aws_appautoscaling_target.service_autoscaling[each.key].resource_id
#   scalable_dimension = aws_appautoscaling_target.service_autoscaling[each.key].scalable_dimension
#   service_namespace  = aws_appautoscaling_target.service_autoscaling[each.key].service_namespace

#   target_tracking_scaling_policy_configuration {
#     predefined_metric_specification {
#       predefined_metric_type = "ECSServiceAverageMemoryUtilization"
#     }

#     target_value = each.value.auto_scaling.memory.target_value
#   }
# }

# resource "aws_appautoscaling_policy" "ecs_policy_cpu" {
#   for_each           = var.service_config
#   name               = "${var.app_name}-cpu-autoscaling"
#   policy_type        = "TargetTrackingScaling"
#   resource_id        = aws_appautoscaling_target.service_autoscaling[each.key].resource_id
#   scalable_dimension = aws_appautoscaling_target.service_autoscaling[each.key].scalable_dimension
#   service_namespace  = aws_appautoscaling_target.service_autoscaling[each.key].service_namespace

#   target_tracking_scaling_policy_configuration {
#     predefined_metric_specification {
#       predefined_metric_type = "ECSServiceAverageCPUUtilization"
#     }

#     target_value = each.value.auto_scaling.cpu.target_value
#   }
# }
