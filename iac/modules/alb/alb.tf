resource "aws_lb" "alb" {
  load_balancer_type = "application"
  name               = "alb-${var.project_name}"
  security_groups    = var.sg_alb
  subnets            = var.public_subnets
  tags = merge(
    var.tags,
    {
      Name = "alb-${var.project_name}"
    }
  )
}

resource "aws_lb_target_group" "alb_tg" {
  name     = "tg-${var.project_name}"
  port     = 80
  protocol = "HTTP"
  tags = merge(
    var.tags,
    {
      Name = "tg-${var.project_name}"
    }
  )

  target_type = "instance"
  vpc_id      = var.vpc_id

  health_check {
    healthy_threshold = 2
    path              = "/"
    matcher           = "200,301,302"
  }

  stickiness {
    cookie_duration = 3600
    enabled         = true
    type            = "lb_cookie"
  }
}

resource "aws_lb_listener" "alb_listener_http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "alb_listener_https" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = data.aws_acm_certificate.cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}

resource "aws_route53_record" "alias_route53_record" {
  zone_id = data.aws_route53_zone.route53_zone.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}
