locals {
  // Flatten the list of ingresses in the ECS service config
  container_ingresses = flatten([
    for container in var.containers : [
      for port in container.ports : [
        for ingress in port.ingresses : {
          container_name = container.name
          container_port = port.container_port
          hostname       = ingress.hostname
          path           = ingress.path
          # strip the first subdomain block so we are left with just the domain
          domain = trimprefix(ingress.hostname, "${element(split(".", ingress.hostname), 0)}.")
        }
      ]
    ]
  ])
  // Extract out the set of domains desired in the ECS service to lookup in Route53
  container_ingress_domains = toset(distinct([for ingress in local.container_ingresses : ingress.domain]))
  // Create a map with the unique pairings of container and port. This is needed for creating and associating target groups
  container_ingress_port_map = { for ingress in local.container_ingresses :
    "${ingress.container_name}-${ingress.container_port}" => {
      container_name = ingress.container_name
      container_port = ingress.container_port
      domain         = ingress.domain
    }
  }

  // Flatten the ALB listeners into a list of objects for each variation of ingress, listener and domain to make it more easily searchable
  cluster_listeners = flatten([
    for ingress in var.ecs_cluster.data.capabilities.ingress : [
      for listener in ingress.listeners : [
        for domain in listener.domains : {
          load_balancer_arn  = ingress.load-balancer-arn
          security_group_arn = ingress.security-group-arn
          listener_arn       = listener.arn
          port               = listener.port
          protocol           = listener.protocol
          domain             = domain
        }
      ]
    ]
  ])

  // The ECS service needs to key off of the ECS ingress (ALB) domains. Iterate through the list of cluster listeners and create
  // a map of domain -> HTTPS listener that matches the domain, port and protocol
  domain_to_https_cluster_listener_map = {
    for listener in local.cluster_listeners : listener.domain => element(flatten([
      for domain_check in [
        for port_check in [
          for protocol_check in local.cluster_listeners : protocol_check if protocol_check.protocol == "https"
        ] : port_check if port_check.port == 443
      ] : domain_check if domain_check.domain == listener.domain
    ]), 0)
  }
}

resource "aws_lb_target_group" "service" {
  for_each = local.container_ingress_port_map
  // Maximum length is 32 characters. Append the port and take the last 32 chars
  name        = trimprefix(substr("${var.md_metadata.name_prefix}-${each.value.container_port}", -32, -1), "-")
  port        = each.value.container_port
  protocol    = "HTTP"
  vpc_id      = local.vpc_id
  target_type = "ip"
}

resource "aws_lb_listener_rule" "service" {
  for_each     = { for ingress in local.container_ingresses : "${ingress.hostname}${ingress.path}" => ingress }
  listener_arn = local.domain_to_https_cluster_listener_map[each.value.domain].listener_arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.service["${each.value.container_name}-${each.value.container_port}"].arn
  }

  condition {
    path_pattern {
      values = [each.value.path]
    }
  }

  condition {
    host_header {
      values = [each.value.hostname]
    }
  }
}
