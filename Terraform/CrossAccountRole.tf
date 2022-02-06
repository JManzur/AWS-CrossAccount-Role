# Establish trust relationships with the provided account.
resource "aws_iam_role" "AWSControlTowerExecution" {
  name = "AWSControlTowerExecution"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "sts:AssumeRole",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::${var.TrustedAccountID}:root"
        }
      }
    ]
    }
  )
}

# Allow Administrator Access on all resources.
resource "aws_iam_role_policy" "AWSControlTowerExecutionPolicy" {
  name = "AWSControlTowerExecutionPolicy"
  role = aws_iam_role.AWSControlTowerExecution.id

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "*",
        "Resource" : "*",
        "Effect" : "Allow",
        "Sid" : "AWSControlTowerExecution"
      }
    ]
  })
}