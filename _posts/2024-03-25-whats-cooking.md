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
- [Our Project](#our-project)
- [Application Architecture](#application-architecture)
- [Leveraging AI](#leveraging-ai):
	- [The Good](#the-good)
	- [The Bad](#the-bad)
	- [The Ugly](#the-ugly)
- [Conclusion](#conclusion)

# Introduction

We started our internship at Ordina with the assignment of developing an application which takes away the stress of deciding what's for dinner.
And what better excuse do we need to test the culinary knowledge of several Large Language Models?
This article will take you through the application's development process, highlighting its various aspects along the way.

# Our Project

For our internship project, we dished out something delightful: "What's Cooking with AI"
Imagine a Chrome extension that serves up AI-crafted recipes based on your online shopping list.
To cook up this magic, we crafted custom web scrapers to gather data from major Belgian online retailers like Colruyt, Delhaize, Albert Heijn, and Aldi.

In the backend (our Java setup), we seamlessly integrated Spring AI, opening the door to a variety of AI models, including heavy hitters like OpenAI's ChatGPT, Command by Cohere, Meta's LLama2 and Amazon's Titan.

On the frontend, we spruced up the user interface with React and Next.js.
Initially simple, just spitting out recipes, but soon we added a pinch of customization, letting users fine-tune preferences like dietary restrictions and culinary whims.

But hold onto your chef's hat!
We also added a nifty feature that conjures up a snapshot of what your dish might look like.
And, of course, you can save those recipe gems for later in a convenient text file.

And if reading isn't your thing while cooking, fear not!
We've integrated a feature that allows you to listen to the recipe being read aloud, ensuring your hands stay free and your focus remains on creating culinary masterpieces.

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

# Leveraging AI

The manner in which we put the Large Language Models to use surpasses the simple Q&A type of prompting.
We require that the content it delivers is not only relevant, but is structured in such a way we can further process it in an OOP environment.
This makes the prompts highly parameterised and can prove quite challenging, depending on the exact model used.

## The Good

By integrating AI we were able to implement solutions that would otherwise require additional assets.
For us, this meant we did not have collect and deploy a large dataset for ingredients and recipes.
This task was replaced by prompting Artificial Intelligence, cutting down on cost, resources, and time spent developing. 

## The Bad

When our user requests a recipe, we start by checking whether the ingredients in their shopping basket are edible.
This challenges the AI's capability to reliably judge a list of ingredients by filtering out the inedible.
We expect that any harmful, toxic, or otherwise ingredients unsafe for human consumption will be filtered out this way... which is not always the case.

As we now have our definitive list of ingredients, we can focus on crafting a recipe.
The AI model must consider all user-provided requirements and consistently format its responses in a pre-determined manner.
Any structural deviation in its response results in failure to parse it into a Java object.

## The Ugly

To address the structural issue there are two potential solutions.

The first approach is training a custom AI model.
Although this requires additional time and resources, it could prove beneficial over time by streamlining prompt messages and decreasing the number of tokens used per prompt.

The second approach involves utilizing an "untrained" AI model and supplying it with elaborate prompt messages.
To ensure proper formatting of the AI model's response, we implemented a prompting technique known as <a href="https://www.promptingguide.ai/techniques/fewshot" target="_blank">Few-Shot Prompting</a>.
Essentially, we provide it an examplatory mock object structure from which it can discern a pattern to apply in its own response.
Using this method does not require complex training nor advanced configuration of AI models.
Given that prompts are stateless, meaning there is no relation between previous or future prompts, we must provide all necessary information and instructions in each prompt.

# Conclusion

Looking back, this project provided us the opportunity to get hands-on experience with various Amazon Web Services, DevOps, and many other aspects of project development.
We got to play around with different types AI models and by exploring their capabilities we got to know their strengths and weaknesses.
The experience we gained and the lessons we learned are definitely something we will take with us into future projects.
