---
layout: post
authors: [yolan_vloeberghs, nicholas_meyers]
title: 'Seamless User Authentication: Bridging Azure AD and AWS Cognito'
image: /img/2023-09-18-cognito-azure-ad/banner.jpg
tags: [ Cloud, AWS, Cognito, Azure, Terraform, Security, Authentication ]
category: Cloud
comments: true
---
# Table of contents
{:.no_toc}
- TOC
{:toc}
# Introduction
In today's interconnected digital landscape, enterprises are increasingly relying on a mix of cloud solutions to meet their diverse needs.
One common challenge is efficiently managing user identities and authentication across these platforms.
But what happens when you're already invested in Azure Active Directory as your primary identity provider?

While many companies utilize Azure AD, they may not fully adopt the entire Azure ecosystem.
This is especially noteworthy since a significant number of enterprises rely on the Microsoft ecosystem, including the widely-used Office 365 suite.
Implementing Single Sign-On is considered a security best practice because it simplifies the process of onboarding and offboarding employees, facilitates access management, and enables policy enforcement for specific users.
Due to the widespread use of Office 365, Azure AD is commonly employed by enterprises for managing Single Sign-On.

However, if your applications are hosted on AWS, it may be more beneficial to opt for AWS Cognito to oversee the Single Sign-On for these applications.
Although an AWS Lambda function could authenticate with Azure AD, AWS Cognito provides a convenient approach to incorporate authentication within AWS services like API Gateway and CloudFront.

In this article, we'll explore how to efficiently integrate users from your Azure AD environment into AWS Cognito.
Can these two seemingly distinct systems work together to provide a unified authentication experience?
Let's delve into the details and discover how this integration can be seamlessly achieved.

To keep things straightforward, we will utilize [Terraform](https://www.terraform.io/) to establish the infrastructure.
This setup can be easily replicated across various AWS and Azure accounts for convenience.
# Infrastructure setup
The setup process will span across the two specified cloud platforms: Azure and AWS.
The initial phase involves establishing an App Registration within Azure AD, followed by the creation of a user pool in AWS Cognito.
These components will then be synchronized together.

Optionally, there's the option to include a Lambda function within AWS Cognito that facilitates the synchronization of groups from Azure AD into AWS Cognito.
This becomes significant when users within Azure AD are categorized into groups, and if you seek to manage permissions based on the various types of groups present.
## Azure AD
We should create an App Registration within Azure AD which will be utilized in a later stage by AWS Cognito.
Every authentication request should redirect back with a response to our Cognito domain.

Optionally, you are able to synchronize Azure AD groups with AWS Cognito.
This synchronization involves utilizing the `required_resource_access` block.
This synchronization can be valuable for permissions administration linked to distinct groups like MANAGEMENT.

More information about the different resource apps and which ID's to use can be found [here](https://learn.microsoft.com/en-us/troubleshoot/azure/active-directory/verify-first-party-apps-sign-in#application-ids-of-commonly-used-microsoft-applications){:target="_blank" rel="noopener noreferrer"}.
For Microsoft Graph, the ID that we should use is `00000003-0000-0000-c000-000000000000`.

More information about the different roles for Microsoft Graph and which ID's to use can be found [here](https://learn.microsoft.com/en-us/graph/permissions-reference#all-permissions-and-ids){:target="_blank" rel="noopener noreferrer"}.
For the `Directory.Read.All` role, the ID should be `7ab1d382-f21e-4acd-a863-ba3e13f7da61`.

**Please note, you need to give consent manually to the API permissions of your App Registration. 
This can be done in the `API permissions` section of your App Registration.**

Additionally, it's essential to generate a client secret for the application with the `azuread_application_password` resource.
This secret facilitates Cognito's authentication with Azure AD and enables configuring your identity provider within the Cognito environment.
```terraform
resource "azuread_application" "application" {
  display_name = "example-application-for-aws"

  web {
    redirect_uris = [
      "https://example-application.auth.eu-west-1.amazoncognito.com/oauth2/idpresponse"
    ]
  }

  required_resource_access {
    resource_app_id = "00000003-0000-0000-c000-000000000000" # Microsoft Graph
    resource_access {
      id   = "7ab1d382-f21e-4acd-a863-ba3e13f7da61" # Directory.Read.All
      type = "Role"
    }
  }
}

resource "azuread_application_password" "application_password" {
  application_object_id = azuread_application.application.object_id
}
```

{:refdef: style="text-align: center;"}
<img src="{{ '/img/2023-09-18-cognito-azure-ad/azure-ad-overview.jpg' | prepend: site.baseurl }}" alt="Azure AD: Overview" class="image fit" style="margin:0px auto; max-width:100%">
_Overview_
{: refdef}

{:refdef: style="text-align: center;"}
<img src="{{ '/img/2023-09-18-cognito-azure-ad/azure-ad-redirect.jpg' | prepend: site.baseurl }}" alt="Azure AD: Redirect" class="image fit" style="margin:0px auto; max-width:100%">
_Redirect URL_
{: refdef}

{:refdef: style="text-align: center;"}
<img src="{{ '/img/2023-09-18-cognito-azure-ad/azure-ad-secret.jpg' | prepend: site.baseurl }}" alt="Azure AD: Client secret" class="image fit" style="margin:0px auto; max-width:100%">
_Client secret_
{: refdef}
## (Optional) AWS Lambda
Should you choose to synchronize your Azure AD user groups with AWS Cognito, it is mandatory to generate this Lambda function.
This Lambda function will be triggered following the confirmation of your account and after each instance of account authentication.
The source code of the Lambda can be found [here](https://github.com/Ordina-Group/lambda-add-user-to-groups){:target="_blank" rel="noopener noreferrer"}.

This provided Terraform code enables you to deploy the Lambda function within your AWS account with the correct set of permissions.
Terraform was selected for deployment due to its widespread use throughout the entire project; however, it's worth noting that alternatives like [AWS SAM](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/what-is-sam.html){:target="_blank" rel="noopener noreferrer"} and [Serverless](https://www.serverless.com/){:target="_blank" rel="noopener noreferrer"} are also available.
```terraform
data "archive_file" "user_to_group_lambda_file" {
  type        = "zip"
  source_dir  = "<path_to_source_code>"
  output_path = "lambda-add-user-to-groups.zip"
}

data "aws_iam_policy_document" "user_to_group_lambda_iam_policy_document" {
  statement {
    effect = "Allow"
  
      principals {
        type        = "Service"
        identifiers = ["lambda.amazonaws.com"]
      }
  
      actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "user_to_group_lambda_iam_role" {
  name = "lambda-add-user-to-groups-role"
  
  assume_role_policy = data.aws_iam_policy_document.user_to_group_lambda_iam_policy_document.json
}

resource "aws_lambda_function" "user_to_group_lambda_function" {
  filename         = "lambda-add-user-to-groups.zip"
  function_name    = "lambda-add-user-to-groups"
  handler          = "index.handler"
  role             = aws_iam_role.user_to_group_lambda_iam_role.arn
  
  source_code_hash = data.archive_file.user_to_group_lambda_file.output_base64sha256
  
  runtime          = "nodejs18.x"
}

resource "aws_lambda_permission" "user_to_group_lambda_permission" {
  statement_id  = "AllowExecutioaws_lambda_permissionnFromCognito"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.user_to_group_lambda_function.function_name
  principal     = "cognito-idp.amazonaws.com"
  source_arn    = aws_cognito_user_pool.cognito_user_pool.arn
}

data "aws_iam_policy_document" "user_to_group_lambda_cognito_iam_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "cognito-idp:AdminAddUserToGroup",
      "cognito-idp:CreateGroup"
    ]

    resources = [aws_cognito_user_pool.cognito_user_pool.arn]
  }
}

resource "aws_iam_policy" "user_to_group_lambda_cognito_iam_role" {
  name        = "lambda-user-to-group-cognito-policy"
  description = "IAM policy for add user to cognito user group from a lambda"
  policy      = data.aws_iam_policy_document.user_to_group_lambda_cognito_iam_policy_document.json
}

resource "aws_iam_role_policy_attachment" "user_to_group_lambda_cognito_iam_role_policy_attachment" {
  role       = aws_iam_role.user_to_group_lambda_iam_role.name
  policy_arn = aws_iam_policy.user_to_group_lambda_cognito_iam_role.arn
}
```
## AWS Cognito
To start, the initial step involves setting up a Cognito user pool. 

If you opt to synchronize user groups from Azure AD to Cognito, it's necessary to fill in the `lambda_config` block.
The `post_confirmation` trigger is invoked by AWS Cognito once a newly registered user confirms their user account. 
Similarly, the `post_authentication` trigger is activated after a user successfully signing in.
Both triggers invoke the same lambda.


```terraform
resource "aws_cognito_user_pool" "cognito_user_pool" {
  name = "example-application-for-aws-user-pool"

  lambda_config {
    post_confirmation   = aws_lambda_function.user_to_group_lambda_function.arn
    post_authentication = aws_lambda_function.user_to_group_lambda_function.arn
  }
}
```

{:refdef: style="text-align: center;"}
<img src="{{ '/img/2023-09-18-cognito-azure-ad/cognito-pool-properties.jpg' | prepend: site.baseurl }}" alt="AWS Cognito: User pool properties" class="image fit" style="margin:0px auto; max-width:100%">
_User pool properties_
{: refdef}

A redirect URL was previously mentioned in the Azure AD App Registration.
The following block will then generate the associated domain URL within AWS Cognito.
```terraform
resource "aws_cognito_user_pool_domain" "cognito_user_pool_domain" {
  domain       = "example-application"
  user_pool_id = aws_cognito_user_pool.cognito_user_pool.id
}
```

{:refdef: style="text-align: center;"}
<img src="{{ '/img/2023-09-18-cognito-azure-ad/cognito-domain.jpg' | prepend: site.baseurl }}" alt="AWS Cognito: Domain" class="image fit" style="margin:0px auto; max-width:100%">
_Domain_
{: refdef}

To utilize users from our Azure AD, we must integrate an identity provider rather than generating new users within Cognito.
In this integration, we'll reference the previously created client_id and client_secret from Azure AD.

Additionally, as we aim to synchronize all useful user attributes from Azure AD to AWS Cognito, we're required to complete an attribute mapping. 
The data in the response body of the `attributes_url` variable will be aligned with the corresponding properties in AWS Cognito.

**Please note: Don't forget to fill in your tenant ID.**

```terraform
resource "aws_cognito_identity_provider" "cognito_identity_provider" {
  user_pool_id  = aws_cognito_user_pool.cognito_user_pool.id
  provider_name = "AzureAD"
  provider_type = "OIDC"

  provider_details = {
    authorize_scopes          = "email profile openid"
    client_id                 = azuread_application.application.application_id
    client_secret             = azuread_application_password.application_password.value
    oidc_issuer               = "https://login.microsoftonline.com/${var.tenant_id}/v2.0"
    authorize_url             = "https://login.microsoftonline.com/${var.tenant_id}/oauth2/v2.0/authorize"
    token_url                 = "https://login.microsoftonline.com/${var.tenant_id}/oauth2/v2.0/token"
    attributes_request_method = "GET"
    attributes_url            = "https://graph.microsoft.com/oidc/userinfo"
    jwks_uri                  = "https://login.microsoftonline.com/${var.tenant_id}/discovery/v2.0/keys"
  }

  attribute_mapping = {
    email          = "email"
    name           = "name"
    given_name     = "given_name"
    family_name    = "family_name"
    picture        = "picture"
    email_verified = "email_verified"
  }
}
```
{:refdef: style="text-align: center;"}
<img src="{{ '/img/2023-09-18-cognito-azure-ad/cognito-azuread-identity-provider.jpg' | prepend: site.baseurl }}" alt="AWS Cognito: Domain" class="image fit" style="margin:0px auto; max-width:100%">
_Azure AD Identity Provider_
{: refdef}

For the integration of the authentication process within services such as API Gateway, having the user pool ID is necessary.
This is why we are storing the ID in the Parameter Store, enabling us to retrieve it whenever necessary.
```terraform
resource "aws_ssm_parameter" "ssm_parameter" {
  name  = "example-application-for-aws-user-pool-id"
  type  = "String"
  value = aws_cognito_user_pool.cognito_user_pool.id
}
```
# Conclusion
If you already have an established AD setup and wish to synchronize it with Cognito, this is a recommended approach.
However, you do have the option to authenticate your users directly within your existing AD setup without involving Cognito.
In doing so, though, you give up the advantages of the seamless integration that AWS and Cognito offer for their services.
It's worth noting that using Keycloak with AWS is also discouraged, as it requires manual management and lacks native integration with AWS services.

By synchronizing AWS Cognito with Azure AD, we can seamlessly authenticate our enterprise users across AWS services.
Leveraging two managed services from both clouds, the majority of the authentication process is abstracted away.
Consequently, there's no need to manually make calls to Azure AD for authentication within our AWS-hosted applications.
Instead, we can effortlessly integrate Cognito's native authentication mechanism into services such as API Gateway, CloudFront, and other services.

In this example, we used Terraform to deploy our Lambda function on AWS.
While this method is functional, it is advisable to consider using a framework such as [Serverless](https://www.serverless.com/){:target="_blank" rel="noopener noreferrer"} or [AWS SAM](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/what-is-sam.html){:target="_blank" rel="noopener noreferrer"}.
These frameworks offer a more managed and streamlined approach for deploying Lambda functions on AWS.