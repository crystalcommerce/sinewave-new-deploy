name   = "sinewave-new"
env    = "dev"
health_check_path = "/"
region = "us-east-2"
vpc_id = "vpc-09dadc2ac22c4e084"
app_subnet_ids=["subnet-0ddf5364f7e038028", "subnet-0626499e6073ab61b"]
dmz_subnet_ids=["subnet-067e79ecc5e11f35d", "subnet-07073cf4a2841e96f"]
data_subnet_ids=["subnet-0c91d0f331e3b1eb0", "subnet-0d6deffa6d76447df"]
queue_node_type="cache.m5.large"
redis_url="redis://sinewave-new-queue.cdobfy.0001.use2.cache.amazonaws.com:6379"
smtp_password="3pvyp9c0bcg4"
database_name ="sinewave_new"
database_username ="sinewave_new"
database_password = "a3CT2vQZcL"
database_url = "postgres://sinewave_new:a3CT2vQZcL@dev-sinewave-new.cx6wvscxqgon.us-east-2.rds.amazonaws.com:5432/sinewave_new"
image = "157720553339.dkr.ecr.us-east-2.amazonaws.com/dev-sinewave-new:latest"
master_key = "cf1019ea1f314281e8c208a5b4c8b973"
domain="ccgrid.net"
instance_type = "t3.xlarge"
instance_size = "2"
server_url = "https://sinewave-new-dev.ccgrid.net"
dsn_key = "https://2ad4a7e3228f490084709c6807d98748@o454205.ingest.sentry.io/5444923"
