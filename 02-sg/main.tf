module "db" {
    source = "../../terraform-aws-securitygroup"
    project_name = var.project_name
    environment = var.environment
    sg_description = "sg for db  MYSQL Instances "
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    common_tags = var.common_tags
    sg_name = "db"
}

module "backend" {
    source = "../../terraform-aws-securitygroup"
    project_name = var.project_name
    environment = var.environment
    sg_description = "sg for Backend Instances "
    vpc_id = data.aws_ssm_parameter.vpc_id.value 
    common_tags = var.common_tags
    sg_name = "backend"
}

module "frontend" {
    source = "../../terraform-aws-securitygroup"
    project_name = var.project_name
    environment = var.environment
    sg_description = "sg for front end Instances "
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    common_tags = var.common_tags
    sg_name = "frontend"
}

resource "aws_security_group_rule" "db_backend" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id = module.backend.sg_id
  security_group_id = module.db.sg_id
}

resource "aws_security_group_rule" "backend_frontend" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.frontend.sg_id
  security_group_id = module.backend.sg_id
}

resource "aws_security_group_rule" "frontend_public" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.frontend.sg_id
}