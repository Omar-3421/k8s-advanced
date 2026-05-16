# =============================================================
# locals.tf
# Defines shared variables reused across ALL .tf files.
# Instead of repeating values like the region or project name
# everywhere, we define them once here and reference them
# as local.name, local.region, local.tags etc.
# =============================================================

locals {
  name   = "eks-lab"
  domain = "lab.omarprojects.co.uk"
  region = "eu-west-1"

  tags = {
    Environment = "sandbox"
    Project     = "EKS Advanced Lab"
    Owner       = "Omar"
  }
}