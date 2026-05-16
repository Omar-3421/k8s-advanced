# =============================================================
# irsa.tf
# Creates IAM roles for Kubernetes service accounts (IRSA).
# Gives cert-manager permission to modify Route53 DNS records
# so it can prove domain ownership and issue SSL certificates.
# =============================================================

module "cert_manager_irsa_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "5.30.0"

  role_name                     = "cert-manager"
  attach_cert_manager_policy    = true
  cert_manager_hosted_zone_arns = ["arn:aws:route53:::hostedzone/Z09822181U8Y8EJSKJZKT"]

  oidc_providers = {
    eks = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["cert-manager:cert-manager"]
    }
  }

  tags = local.tags
}


# =============================================================
# External DNS IRSA
# Gives the external-dns service permission to automatically
# update Route53 DNS records when new apps are deployed to
# the cluster, so your domain always points to the right place
# =============================================================

module "external_dns_irsa_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "5.2.0"

  role_name                     = "external-dns"
  attach_external_dns_policy    = true
  external_dns_hosted_zone_arns = ["arn:aws:route53:::hostedzone/Z09822181U8Y8EJSKJZKT"]

  oidc_providers = {
    eks = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["external-dns:external-dns"]
    }
  }

  tags = local.tags
}