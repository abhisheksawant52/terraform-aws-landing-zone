resource "aws_organizations_organization" "this" {
  feature_set = "ALL"

  aws_service_access_principals = [
    "cloudtrail.amazonaws.com",
    "config.amazonaws.com",
    "guardduty.amazonaws.com",
    "ram.amazonaws.com",
    "sso.amazonaws.com",
  ]

  enabled_policy_types = [
    "SERVICE_CONTROL_POLICY",
    "TAG_POLICY",
  ]
}

resource "aws_organizations_organizational_unit" "this" {
  for_each = toset(var.organization_units)

  name      = each.value
  parent_id = aws_organizations_organization.this.roots[0].id
}

resource "aws_organizations_account" "member" {
  for_each = var.accounts

  name      = each.key
  email     = each.value.email
  parent_id = aws_organizations_organizational_unit.this[each.value.ou].id

  # Retain the account (do not close) when removed from Terraform.
  close_on_deletion = false

  lifecycle {
    ignore_changes = [role_name]
  }
}

# Baseline Service Control Policy: deny leaving the organization and disabling
# core security services from member accounts.
data "aws_iam_policy_document" "guardrails" {
  count = var.enable_scp ? 1 : 0

  statement {
    sid       = "DenyLeaveOrganization"
    effect    = "Deny"
    actions   = ["organizations:LeaveOrganization"]
    resources = ["*"]
  }

  statement {
    sid    = "DenyDisableSecurityServices"
    effect = "Deny"
    actions = [
      "guardduty:DeleteDetector",
      "guardduty:DisassociateFromMasterAccount",
      "cloudtrail:StopLogging",
      "cloudtrail:DeleteTrail",
      "config:DeleteConfigurationRecorder",
      "config:StopConfigurationRecorder",
    ]
    resources = ["*"]
  }

  statement {
    sid       = "DenyRootUserActions"
    effect    = "Deny"
    actions   = ["*"]
    resources = ["*"]

    condition {
      test     = "StringLike"
      variable = "aws:PrincipalArn"
      values   = ["arn:aws:iam::*:root"]
    }
  }
}

resource "aws_organizations_policy" "guardrails" {
  count = var.enable_scp ? 1 : 0

  name        = "baseline-guardrails"
  description = "Organization-wide preventive guardrails."
  type        = "SERVICE_CONTROL_POLICY"
  content     = data.aws_iam_policy_document.guardrails[0].json
}

resource "aws_organizations_policy_attachment" "guardrails" {
  count = var.enable_scp ? 1 : 0

  policy_id = aws_organizations_policy.guardrails[0].id
  target_id = aws_organizations_organization.this.roots[0].id
}
