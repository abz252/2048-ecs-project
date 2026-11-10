resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "2048-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 6
        height = 6

        properties = {
          metrics = [

            ["AWS/ApplicationELB",
              "RequestCount",
              "LoadBalancer",
            var.load_balancer_suffix_arn]


          ]
          period = 300
          stat   = "Sum"
          region = var.region
          title  = "ALB Request Count"
        }
      },

      {
        type   = "metric"
        x      = 6
        y      = 0
        width  = 6
        height = 6

        properties = {
          metrics = [

            ["AWS/ApplicationELB",
              "HTTPCode_Target_5XX_Count",
              "LoadBalancer",
            var.load_balancer_suffix_arn]

          ]
          period = 300
          stat   = "Sum"
          region = var.region
          title  = "ALB HTTP 5XX Count"
        }
      },

      {
        type   = "metric"
        x      = 0
        y      = 6
        width  = 6
        height = 6

        properties = {
          metrics = [

            ["AWS/ECS",
              "MemoryUtilization",
              "ServiceName",
              var.service_name,
              "ClusterName",
            var.cluster_name],
            [".",
              "CPUUtilization",
              ".",
              ".",
              ".",
            "."]


          ]
          period = 300
          stat   = "Average"
          region = var.region
          title  = "ECS Service CPU & Memory"
        }
      }

    ]

  })
}

resource "aws_cloudwatch_log_group" "ecs_2048" {
  name              = var.log_group_name
  retention_in_days = var.retention_days

  tags = var.tags
}


resource "aws_cloudwatch_query_definition" "ecs_2048" {
  name = "2048_query"

  log_group_names = [
    var.log_group_name
  ]

  query_string = <<EOF
fields @timestamp, @message
| where @message like /error/
| sort @timestamp desc
| limit 30
EOF
}

resource "aws_cloudwatch_metric_alarm" "CPU" {
  alarm_name          = var.alarm_name
  comparison_operator = var.comparison_operator
  evaluation_periods  = var.evaluation_period
  metric_name         = var.metric_name
  namespace           = var.namespace
  period              = var.period
  statistic           = var.statistic
  threshold           = var.threshold
  alarm_description   = var.alarm_description
  dimensions = {
    ClusterName = var.cluster_name
    ServiceName = var.service_name

  }
}
