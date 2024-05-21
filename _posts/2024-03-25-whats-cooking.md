---
layout: post
authors: [ayoub_ait_cheikh_ahmed, jonathan_moermans, febe_cap]
title: "Whats Cooking with AI"
image: /img/2024-03-25-whatscooking/whatscooking-banner.jpg
tags: [AI, aws, internship, springAI, terraform, docker]
category: AI
comments: true
---

# Table of contents

- [Introduction](#introduction)
- [Leveraging AI](#leveraging-ai)
- [Application Architecture](#application-architecture)
- [Conclusion](#conclusion)

# Introduction

During our internship at Ordina it was our task to develop an application which takes away the stress of deciding what's for dinner.
We devised an easy-to-use Chrome Extension that automatically retrieves the items from your shopping basket, and uses this information to deliver you a recipe.
All you need to do is go to your favourite online supermarket, add some items to your basket, and our application takes care of the rest:

<img alt="Chrome extension recipe flow" src="/img/2024-03-25-whatscooking/whatscooking-chrome-recipe.png" class="image fit">

In this article we will take you through the application's development process, highlighting its various aspects along the way.

# Leveraging AI

When our user requests a recipe, we start by checking whether the ingredients in their shopping basket are edible.
This challenges the AI's capability to reliably judge a list of ingredients by filtering out the inedible.
We expect that any harmful, toxic, or otherwise ingredients unsafe for humans will be filtered out this way.

As we now have our definitive list of ingredients, we can focus on crafting a recipe.
The prompt for the recipe is elaborate, it must contain all the dietary restrictions and ingredients for it to return a suitable suggestion.
For this we implemented a custom prompting technique based on <a href="https://www.promptingguide.ai/techniques/fewshot" target="_blank"  rel="noopener noreferrer">Few-Shot Prompting</a>.
Essentially, we provide it an example answer which the AI can use to form its own response.

In conclusion, by integrating AI we were able to implement solutions that would otherwise require additional assets.
For us, this meant we did not have to collect and deploy a large dataset for ingredients and recipes.
This task was replaced by prompting Artificial Intelligence, cutting down on cost, resources, and time spent developing. 

# Application Architecture

<img alt="Application Architecture Diagram" src="/img/2024-03-25-whatscooking/ArchitectureDiagramBlog.jpg" class="image fit">

In our project, we implemented CI/CD to streamline the deployment process of our backend.
This was achieved by leveraging various tools offered by different providers such as GitHub and Amazon Web Services (AWS).

Initially, we began by writing workflow files to automate the execution of tests with each push to the development branch on GitHub.
Over time, this progressed into developing workflow files aimed at building and deploying our backend onto App Runner, thereby enabling seamless access to our backend without the necessity of local execution.

In our GitHub workflows, the Terraform process begins by accessing the main Terraform file, which maintains the status of all AWS resources it oversees.
If these resources are absent, they are created; if present, they are updated.
Following this, a fresh Docker image is generated and sent to AWS ECR.
Subsequently, App Runner updates itself to host the latest version of the application automatically.

To streamline the orchestration of these jobs, which were authored in separate files for organizational clarity, we utilized a main workflow file to dictate the sequence in which the jobs were to be executed.

In our pursuit of enhancing backend security on App Runner, we opted to integrate an API Gateway.
This serves as a protective layer, mandating that all frontend requests transit through it and ensuring access to the backend only if the appropriate key is present in the request headers.

# Conclusion

Looking back, this project provided us the opportunity to get our first hands-on experience with various Amazon Web Services, DevOps, and many other aspects of project development.
We got to play around with different types AI models and by exploring their capabilities we got to know their strengths and weaknesses.
The experience we gained and the lessons we learned are definitely something we will take with us into future projects.
