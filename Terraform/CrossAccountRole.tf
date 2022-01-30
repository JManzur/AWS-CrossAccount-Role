# Establish trust relationships with the provided account.
resource "aws_iam_role" "ControlTowerCrossAccountRole" {
  name = "ControlTowerCrossAccountRole"

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
resource "aws_iam_role_policy" "ControlTowerCrossAccountPolicy" {
  name = "ControlTowerCrossAccountPolicy"
  role = aws_iam_role.ControlTowerCrossAccountRole.id

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "*",
        "Resource" : "*",
        "Effect" : "Allow",
        "Sid" : "ControlTowerCrossAccountRole"
      }
    ]
  })
}