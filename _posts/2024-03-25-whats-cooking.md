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
- [Used Technologies (DRAFT)](#used-technologies)
- [Application Architecture (DRAFT - Febe)](#application-architecture-draft---febe)
- [Leveraging AI (DRAFT - Jonathan)](#leveraging-ai-draft---jonathan)
- [AI Benchmarking](#ai-benchmarking)
- [Conclusion (DRAFT - Jonathan)](#conclusion-draft---jonathan)


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

In our setup, the backend gets data from the Chrome plugin via an HTTP request. It then dives into various tasks, many of which involve AI.

We can split these AI tasks into two main categories:

- Data cleaning
- Content generation

First up, there's data cleaning. Here, the AI sorts through the data, getting rid of any bits we don't want. In our case, that means sifting out the not-so-tasty ingredients from a bunch that could be edible. 

Without AI, handling this would mean digging into a huge dataset and running loads of searches. But in our app, it's as easy as a single prompt and waiting for the AI's response. It's almost like the AI can tell at a glance if something's safe to eat—talk about stubborn!

Once we've got our ingredients list all sorted, it's time for the second AI task: cooking up some content in the form of recipes.

The AI needs to consider all the recipe requirements and make sure its responses are consistent and clear. 
 
Otherwise, it's like trying to follow a recipe without knowing if you need a pinch or a dash—it just doesn't work!

Now, there are a couple of ways to keep things consistent:

- Custom AI Model: You make your own AI model from scratch. It takes more time and effort, but it fits your needs like a glove.
- Standard AI Model with Detailed Prompts: You use an existing AI model but give it super detailed prompts to guide its performance. 

We went with the second option. Even though the first one might be more efficient in terms of prompts, the second one lets us compare AI models easily by giving them all the same instructions. It's like a taste test for AI!

And to make sure the AI's responses are properly formatted, we used a technique called "Few-Shot Prompting.".

Basically, you give the AI a question and answer to learn from, and it picks up on the pattern. For this, we set up a template to base our prompt on, plugging in the user's data before sending it off to the AI.

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

|  | OpenAI ChatGPT | Bedrock Titan | Cohere Command | Meta Llama2 |
|---|---|---|---|---|
| Strengths | (Add Strengths here) | (Add Strengths here) | * Formatted the anwser without trouble | * Does understand which ingredients are edible and which aren't |
| Weaknesses | (Add Weaknesses here) | (Add Weaknesses here) | * Can't understand Dutch * Isn't good in understanding what is edible and what isn't * Gives basic recipes which often do not take the requested diets into account | * Does not understand Dutch very well * Gives basic recipes when it can be creative * Often it doesn't give recipes which take the requested diet into account |
| Implementation | (Add Implementation details here) | (Add Implementation details here) |  Easy ingredient implementation, harder recipe ingredient implementation  | Harder implementation of both prompts |

## Benchmarking OpenAi ChatGPT

## Benchmarking Bedrock Titan

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


Here's what we've discovered along the way:

- Bringing AI into our code has let us streamline or even replace old-school solutions, ditching the need for hefty datasets. With the right setup, AI is a real game-changer for handling all sorts of data, especially the stuff users throw our way.

- As we built our project, we noticed that different AI models handle big, complex prompts in different ways. Some shine in certain tasks but stumble in others. It's a reminder that picking the right model depends on what we need it to do.

- When it comes to turning AI responses into Java objects, consistency is key. It's like trying to fit puzzle pieces together—if they're all different shapes and sizes, things just don't click.

# Our experience

Our internship adventure wrapped up with us nailing our assignment.

But let's be real—it wasn't all smooth sailing. We faced a bunch of challenges as we tackled the project.

Still, it was a seriously rewarding journey. Battling through obstacles and coming out on top taught us a ton.

And none of it would've been possible without our awesome mentors and colleagues. Their guidance and wisdom were total game-changers every step of the way.
