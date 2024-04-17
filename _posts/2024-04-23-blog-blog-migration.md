---
layout: post
authors: [nicholas_meyers, ferre_vangenechten]
title: 'Migration of our blog to AWS static hosting'
image: /img/2024-0sd4-01-kubecon-2024/banner.png
tags: [cloud, cicd, cloud-native, landing-zone, security, seo, AWS, Github, migration]
category: DevOps
comments: true
---

> KubeCon \| CloudNativeCon EU edition, en francaise ç'année.

# Content table

# About the jworks tech blog
Since 2015, the Jworks Blog has been a place to learn about the latest tech and projects, brought to you by Jworks, Java & Cloud area of Ordina Belgium. Now, as tech keeps moving forward, we're moving our blog too! We want to keep giving you great content, but with a better and more secure experience.

In this post, we'll tell you all about our blog migration. We'll talk about the challenges we faced and how we fixed them. Join us as we show you how change can make things even better!

# Our previous situation
Our blog is made using [Jekyll)](https://jekyllrb.com/){:target="_blank" rel="noopener noreferrer"}, a blog-aware static site generator in Ruby. It was managed within a GitHub Repository under a GitHub Organization. To share our blog posts with the world, we relied on GitHub Pages.
A few years ago, we moved our GitHub Organization to GitHub Enterprise, but we kept the blog repository on our GitHub Organization. GitHub Pages relies on a repository to determine the blog's URL, and we wanted to maintain the same URL without any changes.


# The problem
## No security headers
We did a scan of our blog on GitHub pages to guarantee the quality and security of our blog. And we concluded that we faced a major problem with our security header. We had none...
After some research we discovered that GitHub pages does not option to add Security headers.

FOTO ROOD

## What are security headers
Security headers are like special instructions that a website sends to your web browser when you visit it. These instructions tell your browser how to behave to keep you safe while you're on that website. They help protect against common online threats like hackers trying to steal your information or take control of your browser.

For example, one security header might tell your browser to only communicate with the website over a secure connection, making sure that your data is encrypted. Another header might prevent the website from being loaded inside another website, which can help stop malicious attacks.

Think of security headers as little helpers that work behind the scenes to keep you and your information safe while you're browsing the web.

## The consequences of no security headers
### Security
- Cross-site scriptiong (XSS) attacks
  - Involves injection of malicious scripts into your website.
  - This can be done by an attacker using MIME Sniffing.
- Clickjacking
  - Involves hiding malicious elements under innocent-looking ones to deceive users into clicking on them.

### SEO
Why invest time in creating great content if it isn't safe to interact with? An unsecured site puts users' online safety at risk and can undermine your SEO efforts. 
Google may label your site as unsafe which can damage your reputation and result in less clicks a month.

### Visitors
Visitors can lose trust in your website and leave it.

# Our solution 
We decided to relocate our web hosting from GitHub Pages to a platform that offers the ability to configure security headers.
This led us to migrate to an Amazon S3 bucket within our AWS environment. Here we leverage AWS CloudFront to configure and implement the necessary security headers.
Additionally, we've integrated AWS WAF (Web Application Firewall) into this infrastructure to further enhance our website's security posture.
Besides that Jworks has already some projects on AWS and there is a lot of knowledge present about it.
We're still investing to expand that knowledge.

The need of resolving this security problem, resulted in a win-win opportunity to also migrate the blog-repository from GitHub Organisation to GitHub Enterprise.
However, the old repository still exists, to keep the original domain name and redirect to our new website.

## Action plan details
We've used Terraform as Infrastructure as a Code combined with GitHub Actions to deploy all our resources.
1. AWS WAF
* **Rate limiting** to protect against DDoS Attacks.
* Add Managed AWS:
  * **Common Rules** to protect against exploitation of a wide range of vulnerabilities including those described in OWASP publications.
  * **Known Bad Input Rules** to block requests patterns that are known to be invalid and are associated with  exploitation or discovery of vulnerabilities.
  * **Amazon Ip reputation List**  to block sources associated with bots or other threats.

2. AWS S3 Bucket
We created an S3 bucket that is fully private and only accessible by Cloudfront. 

3. AWS Cloudfront
Firstly we started to configure the origin, which points to our S3 bucket. 
FOTO ORIGINS

After we've configured the security of our cloudfront. Started with connecting our newly created WAF.
And then the most important part, the security headers. Which we will explain briefly.

SECURITY HEADERS
* **Strict-Transport-Security (STS)** to enforce https
* **Content-Security-Policy (CSP)** to protect your site from XSS attacks. By whitelisting resources of approved content, you can prevent the browser from loading malicious assets
* **X-Frame-Options** to prevent your content from being used in a frame by attackers (clickjacking).
* **X-Content-Type-Options** to stop the browser from MIME sniffing and force it to stick with the declared content-type. The only valid value for this header is `X-Content-Type-Options: no-sniff`.
* **Referrer-Policy** to stop sending referrer info in the headers. This way we increase the users privacy when redirecting to other sites.
* **Permissions-Policy** to control which features (camera, location, mic, ...) and APIs can be used in the browser. 
* **X-XSS-Protection** to enable XSS protection on old browsers. Modern browsers uses the CSP headers to do this.


4. AWS Route 53


## Final infrastructure
- S3
- WAF
- Landing zone
- AWS
- Foto groen

## Conclusion
- Link naar Securityheader.com 
- 

    - Repo is verplaatst public -> private
- UPCOMING SECURITY HEADERS
* Cross-Origin-Embedder-Policy (COEP)
* Cross-Origin-Opener-Policy (COOP)
* Cross-Origin-Resource-Policy (CORP)