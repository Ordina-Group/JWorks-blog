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
- [Leveraging AI](#leveraging-ai)
- [Our experience](#our-experience)
- [Conclusion](#conclusion)

# Introduction

In this article, we introduce "What's Cooking with AI", a Chrome extension that helps you make recipes using AI.
At the click of a button, you can see what recipes you can make with the items you have in your shopping basket.

We use fancy AI to figure out what recipes you might like based on your preferences and basket.
In addition to just finding recipes, our application actually creates new ones!
We'll talk about how we built the extension, using stuff like Next.js for the part you see, Spring Boot for the behind-the-scenes stuff, and Amazon's cloud services to make sure everything runs smoothly.
Plus, we'll explain how we set up everything step by step.

We'll also dive into how we tested different AI models to see which one worked best.
It was like a taste test for AI!
And along the way, we'll share the ups and downs we faced while working on this project.

So, join us as we explore the exciting world of AI in cooking, sharing our journey and discoveries along the way.

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

In our application the user starts their culinary journey with a single click on the "Start" button, this delivers the information from the Chrome Extension to our backend via HTTP-request.
Our backend then carries out various operations on this data with most of them leveraging AI.

The first AI operation is cleaning the data by removing undesired elements.
In our context this entails the AI's capability to reliably judge an array of ingredients, filtering out the inedible ones from a collection of potentially edible ingredients.
We expect that any obviously harmful, toxic, or otherwise inedible ingredients will be filtered out in this way.

Once we have this refined list of ingredients, we move on to our second AI operation, which involves generating a recipe.
The AI model must consider all user-provided recipe requirements and consistently format its responses in JSON.
Failure to do so could result in the AI model's responses being challenging to reliably parse into objects in a Java environment.

To address this issue there are two potential solutions.

The first approach entails creating a custom AI model, allocating sufficient resources, and training it to align with your specific use case.
Although the setup process may demand more time and resources, it could streamline prompt messages and decrease the number of tokens used in AI operations.

The second approach involves utilizing a standard AI model while supplying it with detailed prompt messages.
Using this method does not require complex training nor advanced configuration of AI models, allowing us to compare their out-of-the-box performance by providing the same prompt to different AI models.
Given that prompts are stateless, meaning there is no relation between previous or future prompts, we must provide all necessary information, instructions and context in each prompt.

To ensure proper formatting of the AI model's responses, we implemented a prompting technique known as <a href="https://www.promptingguide.ai/techniques/fewshot" target="_blank">Few-Shot Prompting</a>.
Essentially, with Few-Shot Prompting, you provide the AI model with an example question and answer from which it can discern a pattern.

# Our experience

Our internship adventure wrapped up with us nailing our assignment.
But let's be real—it wasn't all smooth sailing.
We faced a bunch of challenges as we tackled the project.

Still, it was a seriously rewarding journey.
Battling through obstacles and coming out on top taught us a ton.
And none of it would've been possible without our awesome mentors and colleagues.
Their guidance and wisdom were total game-changers every step of the way.

# Conclusion

By integrating AI in our application we were able to implement solutions for problems that would otherwise require additional assets.

For example, in our application we have a shopping basket full of items which we want to filter on edibility.
A traditional solution for this might involve a database and several queries.
With the introduction of AI we were able to provide a solution through a single prompt.
But beware, while parsing String responses from the AI model into complex Java objects, one thing becomes abundantly clear: consistency is key.

Finally, during our project we noticed that giving our AI too many instructions in one prompt could lead to unepected results.
So it's better to keep each task well defined for the AI to understand it correctly. 
In addition to this we found that different AI models have strengths and weaknesses. 
Some are great at certain tasks but not so good at others. 
This shows how important it is to carefully pick the right AI based on what you need it to do.
