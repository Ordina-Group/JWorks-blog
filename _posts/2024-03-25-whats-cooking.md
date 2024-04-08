---
layout: post
authors: [ayoub_ait_cheikh_ahmed, jonathan_moermans, febe_cap]
title: "Whats Cooking AI"
image: /img/2024-03-25-whatscooking/whatscooking-banner.jpg
tags: [AI, aws, internship, springAI, terraform, docker]
category: AI
comments: true
---

# Introduction

In this article, we introduce "What's Cooking," a Chrome extension that helps you make recipes using AI. Just by clicking, you can see what recipes you can make with the stuff you have in your shopping basket.

We use fancy AI to figure out what recipes you might like based on your preferences and basket. In addition to just finding recipes, our AI actually creates new ones!

We'll talk about how we built the extension, using stuff like Next.js for the part you see, Spring Boot for the behind-the-scenes stuff, and Amazon's cloud services to make sure everything runs smoothly. Plus, we'll explain how we set up everything step by step.

We'll also dive into how we tested different AI models to see which one worked best. It was like a taste test for AI! And along the way, we'll share the ups and downs we faced while working on this project.

So, join us as we explore the exciting world of AI in cooking, sharing our journey and discoveries along the way.

# Table of contents

- [Introduction](#introduction)
- [Table of contents](#table-of-contents)
- [Our Project (DRAFT - Febe)](#our-project-draft---febe)
- [Used Technologies](#used-technologies) - [Frontend](#frontend) - [Backend](#backend) - [AWS Services](#aws-services) - [CI/CD Pipeline](#cicd-pipeline) - [AI Models](#ai-models)
- [Application Architecture (DRAFT - Febe)](#application-architecture-draft---febe)
- [Leveraging AI (DRAFT - Jonathan)](#leveraging-ai-draft---jonathan)
- [AI Benchmarking](#ai-benchmarking)
  - [Benchmarking comparison between models](#benchmarking-comparison-between-models)
  - [Benchmarking OpenAi ChatGPT](#benchmarking-openai-chatgpt)
  - [Benchmarking Bedrock Titan](#benchmarking-bedrock-titan)
  - [Benchmarking Cohere Command](#benchmarking-cohere-command)
  - [Benchmarking Meta Llama2](#benchmarking-meta-llama2)
- [Conclusion (DRAFT - Jonathan)](#conclusion-draft---jonathan)
- [Our experience](#our-experience)

# Our Project (DRAFT - Febe)

For our internship project, we dished out something delightful: "What's Cooking with ChatGPT."

Imagine a Chrome extension that serves up AI-crafted recipes based on your online shopping list.

To cook up this magic, we crafted custom web scrapers to gather data from major Belgian online retailers like Colruyt, Delhaize, Albert Heijn, and Aldi.

In the backend (our Java setup), we seamlessly integrated Spring AI, opening the door to a variety of AI models, including heavy hitters like OpenAI's ChatGPT, Command by Cohere, Meta's LLama2 and Amazon's Titan.

On the frontend, we spruced up the user interface with React and Next.js. Initially simple, just spitting out recipes, but soon we added a pinch of customization, letting users fine-tune preferences like dietary restrictions and culinary whims.

But hold onto your chef's hat! We also added a nifty feature that conjures up a snapshot of what your dish might look like. And, of course, you can save those recipe gems for later in a convenient text file.

# Used Technologies

### Frontend

- **Next.js:** A React framework that enables functionalities such as server-side rendering and generating static websites, enhancing SEO, performance, and user experience.

- **Chakra UI:** A simple, modular and accessible component library that provides the building blocks to build React applications with speed and ease.

### Backend

- **Spring Boot:** Simplifies the development of new Spring applications through convention over configuration, offering a wide range of functionalities for modern web services.

- **Spring AI:** Spring AI is a framework for building AI applications in Java, inspired by Spring principles for ease of development.

- **LLM (Large Language Models):** Offers advanced capabilities in natural language processing, understanding, generation, and translation, enabling sophisticated interaction and content creation.

### AWS Services

- **ECR (Elastic Container Registry):** Provides a Docker container registry that makes it easy for developers to store, manage, and deploy Docker container images.

- **ECS (Elastic Container Service):** A fully managed container orchestration service that makes it easy to run, stop, and manage containers on a cluster.

- **App Runner:** Provides a managed service for developers to quickly deploy containerized web applications and APIs, without dealing with infrastructure management.

- **Secret Manager:** Helps to protect access to applications, services, and IT resources without the upfront cost and complexity of managing a full infrastructure.

- **DynamoDB:** A fast and flexible NoSQL database service for all applications that need consistent, single-digit millisecond latency at any scale.

- **API Gateway:** Offers a fully managed service that makes it easy for developers to create, publish, maintain, monitor, and secure APIs at any scale.

- **API Gateway API Key:** Utilized for controlling and monitoring API usage and access, enhancing security and usage metrics.

### CI/CD Pipeline

- **GitHub Workflows:** Automates your software development workflows.

- **Terraform:** An infrastructure as code software tool that allows you to build, change, and version infrastructure safely and efficiently.

### AI Models

- **OpenAI Models:** Provides advanced AI models like GPT (Generative Pre-trained Transformer) for natural language understanding, generation, and conversational AI capabilities.

- **AWS AI Model Bedrock Titan:** Bedrock Titan AI is a suite of large language models offered by Amazon for building generative AI applications.

- **Cohere Command:** Cohere Command is a powerful language model designed for enterprises, excelling at following instructions and completing complex tasks.

- **Meta Llama2:** Meta Llama2 is a next-generation large language model known for its commercial-grade capabilities and open-source availability.

# Application Architecture (DRAFT - Febe)

In our project, we implemented CI/CD to streamline the deployment process of our backend.

This was achieved by leveraging various tools offered by different providers such as GitHub and Amazon Web Services (AWS).

Initially, we began by writing workflow files to automate the execution of tests with each push to the development branch on GitHub.

Over time, this progressed into developing workflow files aimed at building and deploying our backend onto App Runner, thereby enabling seamless access to our backend without the necessity of local execution.

Within our GitHub workflow files, we designed jobs dedicated to constructing Docker images using Maven, facilitating the subsequent pushing of the latest backend image to Amazon Elastic Container Registry (ECR).

Following the image push to ECR, we employed Terraform to deploy this image onto App Runner.

To streamline the orchestration of these jobs, which were authored in separate files for organizational clarity, we utilized a main workflow file to dictate the sequence in which the jobs were to be executed.

In our pursuit of enhancing backend security on App Runner, we opted to integrate an API Gateway.

This gateway serves as a protective layer, mandating that all frontend requests transit through it and ensuring access to the backend only if the appropriate key is present in the request headers.

# Leveraging AI (DRAFT - Jonathan)

In our application, the backend receives data via HTTP-request delivered by the Chrome plugin. It then carries out various operations on this data, with most of them leveraging AI.

The first operation is cleaning the data by removing undesired elements.
In our context, this means sifting out inedible ingredients from a collection of potentially edible ones.

Once we have this refined list of ingredients, we move on to our second operation, which involves generating a recipe. The AI model must consider all user-provided recipe requirements and consistently format its responses. Failure to do so could result in the AI model's responses being challenging to reliably parse into objects in a Java environment.

To address this issue, there are two potential solutions.

The first approach entails creating a custom AI model, allocating sufficient resources, and training it to align with your specific use case. Although the setup process may demand more time and resources, it could streamline prompt messages and decrease the number of tokens used in AI operations.

The second approach involves utilizing a standard AI model while supplying it with detailed prompt messages. This method simplifies the comparison of your AI model's out-of-the-box performance, a convenience we appreciated in our study. Given that prompts are stateless, we must furnish all necessary information, instructions, and context with each prompt. To ensure proper formatting of the AI model's responses, we implemented a prompting technique known as "few-shot prompting." Essentially, with few-shot prompting, you provide the AI model with an example question and answer from which it can discern a pattern. For this approach, we devised a template encompassing all required information.

# AI Benchmarking

An aspect that particularly intrigued us was the opportunity to benchmark the Generative AI models used in our project. This benchmarking could be achieved through several approaches:

- **User Ratings Comparison:** Analyzing the ratings, ranging from 1 to 5, that users assign to the responses provided by the AI models. This direct feedback serves as a valuable metric for assessing user satisfaction and the practical utility of the models' outputs.

- **Evaluating Our Experiences Against the Model's Responses:** This involves a more subjective, yet insightful, examination based on our interactions with the model:

  - **Understanding of the Prompt:** Assessing whether the model grasps the essence of the given prompt accurately.

  - **Responsiveness to Prompt Modifications:** Determining if the model effectively incorporates changes to the prompt, adapting its responses accordingly.

  - **Model "Laziness":** This term refers to the model's potential shortcomings in:

    - Not adhering strictly to the prompt's requirements.
    - Failing to retain context throughout the interaction.
    - Not remembering previous responses or prompts, which is crucial for coherent and contextual conversation.

  - **Overall Implementation Experience:** Reflecting on the entire process, including how well-documented and user-friendly the model and its implementation framework were. This encompasses ease of integration, clarity of documentation, and overall developer experience.

These criteria collectively contribute to a comprehensive understanding of the AI models' capabilities, user experience, and developer experience. By accuratly comparing these factors, we aim to give our humble opinion about the strengths and limitations of the Generative AI models within the scope of our project, paving the way for targeted improvements and informed choices in future endeavors.

**Benchmarking material:**
The following link provides access to a spreadsheet file detailing our testing process. The first tab includes various columns with the foundational test data. Subsequent tabs are dedicated to each AI model (OpenAI, Titan, Llama2, Cohere), containing requests, responses, and notes. The final tab features a confusion matrix that illustrates the performance of each AI model.

- link to Excel file

## Benchmarking comparison between models

|                | OpenAI ChatGPT                    | Bedrock Titan                                                                                                                                           | Cohere Command                                                                                                                                                       | Meta Llama2                                                                                                                                                     |
| -------------- | --------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Strengths      | (Add Strengths here)              | Once configured it's consistent in its output in terms of formatting                                                                                    | \* Formatted the anwser without trouble                                                                                                                              | \* Does understand which ingredients are edible and which aren't                                                                                                |
| Weaknesses     | (Add Weaknesses here)             | Titan seems to have difficulties with elaborate prompts with lots of requirements and it can not resolve conflicting or unrealistic recipe requirements | _ Can't understand Dutch _ Isn't good in understanding what is edible and what isn't \* Gives basic recipes which often do not take the requested diets into account | _ Does not understand Dutch very well _ Gives basic recipes when it can be creative \* Often it doesn't give recipes which take the requested diet into account |
| Implementation | (Add Implementation details here) | Building prompts for Titan was not a linear process and involves a lot of trial-and-error (see Weaknesses)                                              | Easy ingredient implementation, harder recipe ingredient implementation                                                                                              | Harder implementation of both prompts                                                                                                                           |

## Benchmarking OpenAi ChatGPT

## Benchmarking Bedrock Titan

// Deze ga ik nog verder uitschrijven want het is iets te beknopt momenteel

AWS Titan is an AI model that is, in its current stage, difficult to finetune using Few-Shot Prompting. Prompt instructions are often not reflected in the output. Without correctly configuring the model its output is extremely inconsistent in terms of structure, making its integration in an OOP environment a liability.

## Benchmarking Cohere Command

When we tested out Cohere Command, it showed it was pretty good at following instructions, especially when it had to make a fancy JSON response. It did better than the most models!

But when it came to making recipes, Cohere Command had some trouble. It couldn't handle special diets very well, and its cooking ideas weren't very exciting. It was like watching a new chef trying to do too much at once!

And when it tried to understand Dutch ingredients, it got a bit confused. It couldn't tell which ones were edible and which ones weren't.

Still, even with these problems, we didn't have too much trouble getting Cohere Command set up. With just a few changes, we made it work.

While it might not have been as amazing as the OpenAI model, Cohere Command still impressed us!

## Benchmarking Meta Llama2

When we put the Meta model Llama2 to the test, we found it pretty skilled at sorting out which ingredients were good to eat and which weren't, especially when they were in English.

But when we tried it with Dutch ingredients, it got a bit mixed up and made some mistakes.

It also tended to stick to basic ingredients, even when it had the chance to get creative and add whatever it wanted to the recipe.

Just like the other models, it didn't do a great job of considering special diets.

Setting up Llama2 was a bit tougher compared to the other models because we had to rewrite the original instructions to make them simpler and clearer. The original instructions were just too complicated!

# Conclusion (DRAFT - Jonathan)

As we translated the String responses from the AI model into Java objects, one thing became abundantly clear: consistency is key. Uniformity is paramount for guaranteeing seamless integration and reliable functionality within our application.

Throughout our project development, we've encountered variations in the comprehensiveness of AI models. While certain models shine in particular tasks, they may falter in others. This highlights the importance of thorough evaluation and selective criteria based on the application's specific requirements.

# Our experience

Our internship adventure wrapped up with us nailing our assignment.

But let's be real—it wasn't all smooth sailing. We faced a bunch of challenges as we tackled the project.

Still, it was a seriously rewarding journey. Battling through obstacles and coming out on top taught us a ton.

And none of it would've been possible without our awesome mentors and colleagues. Their guidance and wisdom were total game-changers every step of the way.
