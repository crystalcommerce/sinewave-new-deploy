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
        "mountPoints": [
            {
                "containerPath": "/app/core/shared/themes",
                "sourceVolume": "shared_themes"
            }
        ],
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
                "name": "APP_ID",
                "value": "${app_id}"
            },
            {
                "name": "SECRET",
                "value": "${secret}"
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