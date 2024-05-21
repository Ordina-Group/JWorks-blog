---
layout: post
authors: [ayoub_ait_cheikh_ahmed, jonathan_moermans, febe_cap]
title: "Benchmarking with whats Cooking with AI"
image: /img/2024-03-25-whatscooking/whatscooking-banner.jpg
tags: [AI, aws, internship, springAI, terraform, docker]
category: AI
comments: true
---

# Table of contents

- [Introduction](#introduction)
- [Benchmarking](#benchmarking)
  - [Comparison between models](#comparison-between-models)
  - [OpenAi ChatGPT](#openai-chatgpt)
  - [Amazon's Titan](#amazons-titan)
  - [Cohere Command](#cohere-command)
  - [Meta Llama2](#meta-llama2)
- [Used Technologies](#used-technologies)
  - [Frontend](#frontend)
  - [Backend](#backend)
  - [AWS Services](#aws-services)
  - [CI/CD Pipeline](#cicd-pipeline)
  - [Infrastructure](#infrastructure)
  - [AI Models](#ai-models)
- [Conclusion](#conclusion)

# Introduction

For our internship project we made a chrome extension called "What's cooking with AI".
In this second blogpost we will pull you through the more technical part of this project.
You can read all about how we benchmarked the ai models we implemented, like OpenAi's ChatGPT and Meta's Llama2.
You can also find a categorised list of all the technologies we used to create this project.

# Benchmarking

An aspect that particularly intrigued us was the opportunity to benchmark the Generative AI models used in our project.
This benchmarking could be achieved through several approaches:

- **User Ratings Comparison:** Analyzing the ratings, ranging from 1 to 5, that users assign to the responses provided by the AI models.
  This direct feedback serves as a valuable metric for assessing user satisfaction and the practical utility of the models' outputs.

- **Evaluating Our Experiences Against the Model's Responses:** This involves a more subjective, yet insightful, examination based on our interactions with the model:

  - **Understanding of the Prompt:** Assessing whether the model grasps the essence of the given prompt accurately.

  - **Responsiveness to Prompt Modifications:** Determining if the model effectively incorporates changes to the prompt, adapting its responses accordingly.

  - **Model "Laziness":** This term refers to the model's potential shortcomings in:

    - Not adhering strictly to the prompt's requirements.
    - Failing to retain context throughout the interaction.
    - Not remembering previous responses or prompts, which is crucial for coherent and contextual conversation.

  - **Overall Implementation Experience:** Reflecting on the entire process, including how well-documented and user-friendly the model and its implementation framework were.
    This encompasses ease of integration, clarity of documentation, and overall developer experience.

These criteria collectively contribute to a comprehensive understanding of the AI models' capabilities, user experience, and developer experience.
By accuratly comparing these factors, we aim to give our humble opinion about the strengths and limitations of the Generative AI models within the scope of our project, paving the way for targeted improvements and informed choices in future endeavors.

**Benchmarking material:**
The following link provides access to a spreadsheet file detailing our testing process.
The first tab includes various columns with the foundational test data.
Subsequent tabs are dedicated to each AI model (OpenAI, Titan, Llama2, Cohere), containing requests, responses, and notes.
The final tab features a confusion matrix that illustrates the performance of each AI model.

### Comparison between models

|                | OpenAI ChatGPT                                                                                                                                                                      | Amazon Titan                                                                                                                                                                                   | Cohere Command                                                                                                                                                                                                                         | Meta Llama2                                                                                                                                   |
| -------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------- |
| Strengths      | The model gives overal good responses, but requires explicit instructions when taking in account restrictions whilst generating the recipe.                                         | Overal good responses. Once configured it's consistent in its output in terms of formatting.                                                                                                   | Easily adapts responses to a specific format (such as JSON).                                                                                                                                                                           | Reliably distinguishes between edible and inedible ingredients.                                                                               |
| Weaknesses     | Sometimes the JSON response is incorrectly generated. We noticed that the model generated recipes with inedible items. But when adjusting the prompt it did filter those items out. | Titan seems to have difficulties with elaborate prompts with lots of requirements and it can not resolve conflicting or unrealistic recipe requirements, for example a vegan recipe with meat. | Cohere doesn't understand Dutch names of ingredients and isn't secure in determining an ingredient's edibility. It also gives basic recipes even when it doesn't need to and doesn't take every diet or other preference into account. | Llama2 doesn't understand Dutch very well. It also gives very basic recipes and does often not take diets and other preferences into account. |
| Implementation | The implementation of OpenAI was a pleasant experience due to their excellent documentation.                                                                                        | Implementing Titan was not a linear process and involved excessive trial-and-error.                                                                                                            | Easy ingredient implementation, difficult recipe implementation.                                                                                                                                                                       | Difficult implementation of both prompts.                                                                                                     |

### OpenAi ChatGPT

Our experience with OpenAI's generative language model has been largely positive, marking one of our first successful interactions with advanced AI for content creation.
The ease of integration and the comprehensive support provided have been standout features.
However, it's important to note that while the model excels in many areas, there were instances where it fell short of our specific needs.
This acknowledgment isn't a dismissal but an insight into what we thought that the model couldn't acheive concidering our requirements and expectations.

However, as with any complex AI system, the nuances of human language and the subtleties of specific requests can sometimes present challenges. For instance, while the model is generally adept at adhering to guidelines and generating safe and appropriate content, there have been instances where the outputs, such as recipes, inadvertently included toxic or non-edible items.
Remarkably, adjusting the prompt has shown to effectively mitigate this issue, underscoring the importance of precise and thoughtful prompt engineering to guide the model's responses more accurately.

One area that has proven particularly challenging involves the generation of content that adheres strictly to dietary preferences or restrictions.
A notable example includes the model's unexpected difficulty in producing vegan recipes without including animal products like "Pork belly." This occurrence suggests a need for further refinement in the model's understanding and categorization of ingredients in relation to specific dietary guidelines.
Additionally, the model's approach to generating lactose-free recipes, by substituting with "lactose-free" options, raises questions about its ability to navigate the nuances between different dietary requirements accurately.

### Amazon's Titan

Currently AWS Titan presents challenges when fine-tuning with Few-Shot Prompting as it often fails to reflect prompt instructions in its output.
Thereby requiring time-consuming implementation in your application.
Failure to configure the model correctly results in highly inconsistent output structures, posing a liability when integrating it into an OOP environment.

After configuring Titan to consistently format responses in JSON, our focus shifts to the content of the recipes it generates.
Ranging from delicious to improbable, such as a vegan dish made with animal products.

In conclusion, while Titan remains a viable option for those seeking an AI model compatible with Few-Shot Prompting, its implementation process proves tedious.

### Cohere Command

When we tested out Cohere Command, it showed it was pretty good at following instructions, especially when it had to make a JSON response.
It did better than the most models!

But when it came to making recipes, Cohere Command had some trouble.
It couldn't handle special diets very well, and its cooking ideas weren't very exciting.
And when it tried to understand Dutch ingredients, it got a bit confused.
It couldn't tell which ones were edible and which ones weren't.

Still, even with these problems, we didn't have too much trouble getting Cohere Command set up.
With just a few changes, we made it work.

The implementation of the prompt to filter out the not-edible ingredients was fairly simple since it didn't require many changes to the original OpenAI prompt for it to work on Cohere.
For the prompt to generate recipes, it was another story.
We had to make quite a bit more changes to the original OpenAI prompt for Cohere to understand what we want it to do.

But while it might not have been as amazing as the OpenAI model, Cohere Command still impressed us!

### Meta Llama2

When we put the Meta model Llama2 to the test, we found it pretty skilled at sorting out which ingredients were good to eat and which weren't, especially when they were in English.
But when we tried it with Dutch ingredients, it got a bit mixed up and made some mistakes.
It also tended to stick to basic ingredients, even when it had the chance to get creative and add whatever it wanted to the recipe.

Just like the other models, it didn't do a great job of considering special diets.
Setting up Llama2 was a bit tougher compared to the other models because we had to rewrite the original instructions to make them simpler and clearer.
The original prompt of the OpenAI model was too complicated for Llama2.

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

- **Secrets Manager:** Allows you to easily store and manage confidential information, such as passwords and access keys.

- **DynamoDB:** A fast and flexible NoSQL database service for all applications that need consistent, single-digit millisecond latency at any scale.

- **API Gateway:** Offers a fully managed service that makes it easy for developers to create, publish, maintain, monitor, and secure APIs at any scale.

- **API Gateway API Key:** Utilized for controlling and monitoring API usage and access, enhancing security and usage metrics.

### CI/CD Pipeline

- **GitHub Workflows:** Automates your software development workflows.

### Infrastructure

- **Terraform:** An infrastructure as code software tool that allows you to build, change, and version infrastructure safely and efficiently.

### AI Models

- **Image Generation**: Dall-e.

- **Text-To-Speech Generation**: Amazon Polly.

- **Large Language Models**: OpenAI ChatGPT, Amazon Titan, Cohere Command, Meta LLama2.

# Conclusion

Now that you know all about our more technical journey on this project, you may be inspired to create something with Ai yourself.
Lucky for you, you won't have to worry about which ai model will be better at generating recipes.
We gained a lot of experience with this project on different new technologies which we hopefully will be able to use in other future projects.
