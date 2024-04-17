---
layout: post
authors: [nicholas_meyers, ferre_vangenechten]
title: 'Migration of our blog to a secure AWS static hosting'
image: /img/2024-0sd4-01-kubecon-2024/banner.png
tags: [cloud, cicd, cloud-native, landing-zone, security, seo, AWS, Github, migration, headers]
category: DevOps
comments: true
---

> KubeCon \| CloudNativeCon EU edition, en francaise ç'année.

# Content table
- [About the jworks tech blog](#about-the-jworks-tech-blog)
- [Our previous situation](#our-previous-situation)

## About the jworks tech blog
Since 2015, the Jworks Blog has been a place to learn about the latest tech, 
experiences and projects, brought to you by Jworks, Java & Cloud area of Ordina Belgium. 
Now, as tech keeps moving forward, we moved our blog too! 
We want to keep giving you great content, but with a better and more secure experience.

In this post, we'll tell you all about our blog migration. 
We'll discuss the security challenges we encountered and the solution we implemented,
along with the infrastructure that powered this transition.
Join us as we show you how change can make things even better!

## Our previous situation
Our blog is made using [Jekyll](https://jekyllrb.com/){:target="_blank" rel="noopener noreferrer"}, 
a blog-aware static site generator in Ruby.
It was managed within a GitHub Repository under our GitHub Organization. 
Leveraging GitHub Pages, we shared our blog posts with a global audience.

Despite migrating our GitHub Organization to GitHub Enterprise a few years ago, we 
retained our blog repository within the organization.
GitHub Pages relies on a repository to determine the blog's URL, 
and we wanted to maintain the same URL without any changes.

## The problem
### No security headers
We did a scan of our blog website to ensure its quality and security. 
We concluded that we faced a major problem with our security headers. We had none...
After some research we found that GitHub Pages doesn't provide an option to add these
crucial security measures.

FOTO ROOD

### What are security headers
Security headers are like special instructions that a website sends to your web 
browser when you visit it. These instructions tell your browser how to behave to 
keep you safe while you're on that website. They help protect against common online 
threats like hackers trying to steal your information or take control of your browser.

For example, one security header might tell your browser to only communicate with
the website over a secure connection, making sure that your data is encrypted. 
Another header might prevent the website from being loaded inside another website, 
which can help stop malicious attacks.

Think of security headers as little helpers that work behind the scenes to 
keep you and your information safe while you're browsing the web.

### The consequences of no security headers
#### Security
- Cross-site scriptiong (XSS) attacks
  - Involves injection of malicious scripts into your website.
  - This can be done by an attacker using MIME Sniffing.
- Clickjacking
  - Involves hiding malicious elements under innocent-looking ones to deceive users into clicking on them.

#### SEO
Why invest time in creating great content if it isn't safe to interact with? An unsecured site puts users' online safety at risk and can undermine your SEO efforts. 
Google may label your site as unsafe which can damage your reputation and result in less clicks a month.

#### Visitors
Visitors can lose trust in your website and leave it.

## Our solution 
To address the security concerns, we made the decision to move our web hosting from GitHub
Pages to a platform that allows us to configure security headers. This led us to migrate
our blog to an Amazon S3 bucket within our AWS environment. Here we utilize AWS CloudFront
to set up and enforce the necessary security headers.

In addition, we've implemented an AWS WAF (Web Application Firewall) into our infrastructure
to further enhance our website's security posture. Given our existing experience with AWS 
through previous project, we decided to leverage the platform for its robus security features.

By resolving this security issue, we seized the opportunity to migrate our blog 
repository from GitHub Organization to GitHub Enterprise. 
However, the old repository remains in place to preserve the original 
domain name and redirect users to our new website.

### Action plan details
We've used Terraform as Infrastructure as a Code combined with GitHub Actions to deploy all our resources.
1. AWS WAF
* Implemented **Rate limiting** to protect against DDoS Attacks.
* Integrated Managed AWS Rules:
  * **Common Rules** to protect against exploitation of a wide range of vulnerabilities including those described in OWASP publications.
  * **Known Bad Input Rules** to block requests patterns that are known to be invalid and are associated with  exploitation or discovery of vulnerabilities.
  * **Amazon Ip reputation List**  to block sources associated with bots or other threats.

2. AWS S3 Bucket
* We created an S3 bucket that is fully private and only accessible by Cloudfront. 

3. AWS ACM & Route 53
* Created a subdomain for our blog using Route 53. 
* Generated a certificate via AWS ACM to ensure secure connections for our visitors. 
This certificate will be integrated into our CloudFront configuration.

4. AWS Cloudfront
* Initiated configuration of the origin, directing to our S3 bucket.
* Following the setup of CloudFront security, we proceeded to connect our WAF
* Implemented crucial security header, including:
  * **Strict-Transport-Security (STS)** to enforce https
  * **Content-Security-Policy (CSP)** to protect your site from XSS attacks. By whitelisting resources of approved content, you can prevent the browser from loading malicious assets
  * **X-Frame-Options** to prevent your content from being used in a frame by attackers (clickjacking).
  * **X-Content-Type-Options** to stop the browser from MIME sniffing and force it to stick with the declared content-type. The only valid value for this header is `X-Content-Type-Options: no-sniff`.
  * **Referrer-Policy** to stop sending referrer info in the headers. This way we increase the users privacy when redirecting to other sites.
  * **Permissions-Policy** to control which features (camera, location, mic, ...) and APIs can be used in the browser. 
  * **X-XSS-Protection** to enable XSS protection on old browsers. Modern browsers uses the CSP headers to do this.

### Final infrastructure
FOTO DIAGRAM

## Result
Through this transition to AWS infrastructure and the implementation of 
comprehensive security measures, we've significantly enhanced the security 
and reliability of our platform.

FOTO GROEN


## Conclusion

- Link naar Securityheader.com
- UPCOMING SECURITY HEADERS
* Cross-Origin-Embedder-Policy (COEP)
* Cross-Origin-Opener-Policy (COOP)
* Cross-Origin-Resource-Policy (CORP)