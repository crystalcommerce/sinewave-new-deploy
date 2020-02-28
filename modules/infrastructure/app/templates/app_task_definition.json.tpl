[
    {
        "name": "app",
        "image": "${image}",
        "portMappings": [
            {
                "containerPort": ${port},
                "hostPort": ${port}
            }
        ],
        "memory": 300,
        "networkMode": "awsvpc",
        "environment": [
            {
                "name": "RAILS_ENV",
                "value": "production"
            },
            {
                "name": "DATABASE_URL",
                "value": "${database_url}"
            },
            {
                "name": "RAILS_MASTER_KEY",
                "value": "${master_key}"
            },
            {
                "name": "RAILS_SERVE_STATIC_FILES",
                "value": "true"
            }
        ],
        "logConfiguration": {
            "logDriver": "awslogs",
            "options": {
                "awslogs-group": "${log_group}",
                "awslogs-region": "${region}",
                "awslogs-stream-prefix": "app"
            }
        }
    }
]
