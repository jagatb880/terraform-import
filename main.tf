provider "aws" {
  region = "us-east-1"
}

resource "aws_ecr_repository" "my_repository" {
  name = "nodejs-app" # Replace with the name of your ECR repository
}
//terraform import aws_ecr_repository.my_repository nodejs-app

resource "aws_ecs_cluster" "my_cluster" {
  name = "nodejs-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}
//terraform import aws_ecs_cluster.my_cluster nodejs-cluster

resource "aws_ecs_service" "my_service" {
  name = "nodejs-service"
}
//terraform import aws_ecs_service.my_service nodejs-cluster/nodejs-service

resource "aws_instance" "my_instance" {
}
//terraform import aws_instance.my_instance <instance_id>

resource "aws_ecs_task_definition" "my_task_definition" {
  family                = "nodejs-app-td"
  revision              = "1"
  container_definitions = file("${path.module}/task_definition.json")
  execution_role_arn    = "arn:aws:iam::123456789012:role/ecs-task-execution-role"
  network_mode          = "bridge"
}
//terraform import aws_ecs_task_definition.my_task_definition <my_task_definition>

resource "aws_cognito_user_pool" "my_user_pool" {
  name = "demouserpool"
}
//terraform import aws_cognito_user_pool.my_user_pool <user_pool_id>

resource "aws_cognito_identity_pool" "my_identity_pool" {
  identity_pool_name = "DemoIdentityPool"
}
//terraform import aws_cognito_identity_pool.my_identity_pool <identity_pool_id>


//Creation of User Pool
//https://www.youtube.com/watch?v=KMk73SDYLys

//Creation of Identity Pool
//https://www.youtube.com/watch?v=su-LPbD66Kc&t=345s
