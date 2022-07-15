#Create IAM instance Profile for attaching with the Web Server
resource "aws_iam_instance_profile" "app_instance_profile" {
  name = "${var.env}-${var.app_name}-instance_profile"
  role = aws_iam_role.app_role.name
}

# IAM role for the application
resource "aws_iam_role" "app_role" {
  name               = "${var.env}-${var.app_name}-instance_role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role_policy.json
}

# Policy Document for assuming role for ec2 service
data "aws_iam_policy_document" "ec2_assume_role_policy" {
  version = "2012-10-17"
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole",
    ]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# Attach S3 Policy with the application role
resource "aws_iam_role_policy_attachment" "server_s3_policy_attach" {
  role       = aws_iam_role.app_role.name
  policy_arn = aws_iam_policy.s3_server_policy.arn
}

# S3 Server Policy for accessing S3 service
resource "aws_iam_policy" "s3_server_policy" {
  name        = "${var.env}-${var.app_name}-s3_server_access_policy"
  policy      = data.aws_iam_policy_document.s3_access_policy_doc.json
}

#S3 Policy Document 
data "aws_iam_policy_document" "s3_access_policy_doc" {
  statement {
    effect = "Allow"
    actions = [
      "s3:List*",
      "s3:Get*",
      "s3:Put*"
    ]
    resources = [
      #aws_s3_bucket.example.arn
      "*"
    ]
  }
}


# # S3 Policy Document 
# data "aws_iam_policy_document" "s3_access_policy_doc" {
#   statement {
#     effect = "Allow"
#     actions = [
#       "s3:ListBucket"
#     ]
#     resources = [
#       #aws_s3_bucket.example.arn
#       "*"
#     ]
#   }
#   statement {
#     effect = "Allow"
#     actions = [
#       "s3:GetObject",
#       "s3:PutObject"
#     ]
#     resources = [
#       #"${aws_s3_bucket.example.arn}/*"
#       "*"      
#     ]
#   }
# }
