variable "certificate_url" {
  description = "URL for the OIDC provider's certificate"
  type        = string
}

variable "oidc_provider_url" {
  description = "URL for the OIDC provider"
  type        = string
}

variable "client_id" {
  description = "Client ID for the OIDC provider"
  type        = string
}

variable "variable_aud" {
  description = "Variable for the audience condition in the IAM policy"
  type        = string
}

variable "variable_aud_values" {
  description = "Values for the audience condition in the IAM policy"
  type        = list(string)
}

variable "variable_sub" {
  description = "Variable for the subject condition in the IAM policy"
  type        = string
}

variable "variable_sub_values" {
  description = "Values for the subject condition in the IAM policy"
  type        = list(string)
}

variable "github_role_name" {
  description = "Name of the IAM role for GitHub Actions"
  type        = string
}

#Copy the following variables into a new file called github-role.tfvars and fill in the values for your GitHub repository and workflow.

#certificate_url = "https://token.actions.githubusercontent.com/.well-known/openid-configuration"
#oidc_provider_url = "https://token.actions.githubusercontent.com"
#client_id = "sts.amazonaws.com"
#variable_aud = "token.actions.githubusercontent.com:aud"
#variable_aud_values = ["sts.amazonaws.com"]
#variable_sub = "token.actions.githubusercontent.com:sub"
#variable_sub_values = ["repo:<your-github-username>/<your-repo-name>:ref:refs/heads/<your-branch-name>"]
#github_role_name = "<your-github-role-name>"   