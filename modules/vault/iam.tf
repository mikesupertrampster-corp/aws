resource "aws_iam_role" "vault" {
  name               = "VaultRole"
  assume_role_policy = data.aws_iam_policy_document.ecs.json
}

resource "aws_iam_role_policy" "vault" {
  name   = aws_iam_role.vault.name
  policy = data.aws_iam_policy_document.vault.json
  role   = aws_iam_role.vault.id
}

resource "aws_iam_role" "execution" {
  name               = "VaultEcsTaskExecutionRole"
  assume_role_policy = data.aws_iam_policy_document.ecs.json
}

resource "aws_iam_role_policy_attachment" "execution" {
  for_each   = toset(["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"])
  policy_arn = each.key
  role       = aws_iam_role.execution.name
}
