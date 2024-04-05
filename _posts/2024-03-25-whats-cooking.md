---
layout: post
authors: [ayoub_ait_cheikh_ahmed, jonathan_moermans, febe_cap]
title: "Whats Cooking AI"
image: /img/2024-03-25-whatscooking/whatscooking-banner.jpg
tags: [AI, aws, internship, springAI, terraform, docker]
category: AI
comments: true
---

# Table of contents

- [Table of contents](#table-of-contents)
- [Introduction](#introduction)
- [Used Technologies (DRAFT)](#used-technologies)
- [Our Project (DRAFT - Febe)](#our-project-draft---febe)
- [Application Architecture (DRAFT - Febe)](#application-architecture-draft---febe)
- [Leveraging AI (DRAFT - Jonathan)](#leveraging-ai-draft---jonathan)
- [AI Benchmarking](#ai-benchmarking)
- [Conclusion (DRAFT - Jonathan)](#conclusion-draft---jonathan)

# Introduction

To align with the new trend of generative AI models that are gaining emergent capabilities,we created What'sCooking which is an application where users can easily extract their shopping basket items with a click.

These items undergo analysis by advanced AI, which then suggests personalized recipes based on the user's inventory.

The AI filters the ingredients to ensure the suggestions align with the user's preferences.

The purpose is to test the usage of AI that generates new human-readable content rather than finding or classifying existing content, this falls under the category of LLMs.

More explanations about this will be provided in upcoming sections.

Furthermore, the purpose of Prompt Engineering and how it can make a big difference when tweaking communication with a large chat model will be discussed.

The application doesn't stop at recommendations; it dynamically generates images of suggested recipes.

Users can also personalize their experience on the Preferences page, specifying dietary restrictions and culinary preferences.

Powered by LLM, generative AI, and AWS for deployment, the app is at the forefront of innovation. Continuous updates ensure optimization of pricing, performance benchmarking, and accommodation of diverse user requests.

# Our Project (DRAFT - Febe)

For our internship project, we developed "What's Cooking with ChatGPT."

This entails a Chrome extension designed to suggest AI-generated recipes based on the items currently residing in the user's online shopping basket.

To achieve this, we crafted scrapers specifically tailored to extract data from popular Belgian webshops such as Colruyt, Delhaize, Albert Heijn, and Aldi.

Within our Java backend, we seamlessly integrated Spring AI, facilitating the implementation of various AI models including OpenAI's ChatGPT and Amazon's Titan.

For the frontend, we utilized React and Next.js to craft the interface of our extension.

Initially, our project featured a straightforward interface solely displaying the generated recipe.

Subsequently, we enhanced this interface to offer users the ability to personalize their experience by selecting preferences such as dietary or culinary restrictions.

These preferences serve to tailor the recipe recommendations to the individual user.

Additionally, we incorporated functionality enabling the generation of a reference photo depicting the suggested recipe. Furthermore, users can export recipes to a text file for future reference and use.

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

- **AWS AI Model Bedrock Titan:** While not specifically recognized as "AWS AI Model Bedrock Titan", AWS provides a comprehensive suite of AI services and tools like Amazon SageMaker for building, training, and deploying machine learning models at scale.

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

In our application, the backend receives data delivered by the Chrome plugin via HTTP request.
It performs various operations on this data, most of them involving AI.
We can categorise these AI-operations in to:

- Data cleaning
- Content generation

The first AI-operation is cleaning the data of undesired elements.
In our case this means filtering out the inedible ingredients from a collection of potentially edible ingredients. Without AI, handling this problem would require accessing a large dataset and executing multiple queries. Whereas in our application this entire process was replaced by a single prompt and handling of the response.
It even appears the AI has perfect judgement on whether something is safe for human consumption, and it is more stubborn than you would expect when you try to convince it otherwise.

With this potentially altered list of ingredients we can proceed to our second AI-operation, which is generating content in the shape of a recipe.
The AI model should take into account all the recipe requirements, and format its replies in a consistent & specific way.
Otherwise we run the risk of the AI-model's responses not being able to be reliably parsed into objects in a Java environment.

There are two main approaches to ensure consistency:

- Custom AI Model: Develop a tailored AI model, requiring more initial investment but offering precise alignment with your needs.

- Standard AI Model with Elaborate Prompts: Utilize a pre-existing AI model, supplementing it with detailed prompts to optimise its performance out-of-the-box.

While the prompts are stateless, meaning each prompt is self-contained and does not rely on previous interactions, we must provide all necessary instructions and data for each prompt. Despite the greater token efficiency of the first approach on a prompt-to-prompt basis, we opted for the second approach. This allows us to conveniently compare the performance of AI models by supplying them with the same prompt, facilitating our benchmarking and study.

To ensure proper formatting of the AI-model's replies we used a prompting technique called "Few-Shot Prompting".
Simply put, with Few-Shot Prompting you provide the AI model an example question & answer out of which it can establish a pattern.
For this approach we engineered a template to serve as a basis for our prompt, in which we inject the user supplied data before sending it to the AI.

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
The following link provides access to a spreadsheet file detailing our testing process. The first tab includes various columns with the foundational test data. Subsequent tabs are dedicated to each AI model (OpenAI, Titan, Llama2, Coher), containing requests, responses, and notes. The final tab features a confusion matrix that illustrates the performance of each AI model.

- link to Excel file

## Benchmarking comparison between models

| Feature | OpenAI ChatGPT | Bedrock Titan | Cohere Command | Meta Llama2 |
|---|---|---|---|---|
| Strengths | (Add Strengths here) | (Add Strengths here) | * Formatted the anwser without trouble | * Does understand which ingredients are edible and which aren't |
| Weaknesses | (Add Weaknesses here) | (Add Weaknesses here) | * Can't understand Dutch * Isn't good in understanding what is edible and what isn't * Gives basic recipes which often do not take the requested diets into account | * Does not understand Dutch very well * Gives basic recipes when it can be creative * Often it doesn't give recipes which take the requested diet into account |
| Implementation | (Add Implementation details here) | (Add Implementation details here) |  Easy ingredient implementation, harder recipe ingredient implementation  | Harder implementation of both prompts |

## Benchmarking OpenAi ChatGPT

## Benchmarking Bedrock Titan

## Benchmarking Cohere Command

When benchmarking Cohere Command, we realized it excelled in following instructions.

We requested a JSON response for direct object creation, a task it handled more smoothly than other models.

However, we also discovered its limitations in generating recipes, often failing to align with required dietary restrictions and preferences.

It also wasn't the best in generating recipes in a creative way and adding matching ingredients to the recipe on its own.

The primary issue arose when processing Dutch ingredients; it evidently lacked familiarity with Dutch, leading to difficulty in discerning edibility.

This language barrier was consistent across other models we tested.

The implementation of Cohere Command proved simpler compared to alternative models. 

We could readily adapt prompts from the OpenAI model with minimal adjustments.

While it didn't match the performance of the OpenAI model, as anticipated, it still surpassed our initial expectations.

## Benchmarking Meta Llama2

When benchmarking the Meta model called Llama2, we saw that it was good in filtering the edible and not edible ingredients when the ingredients were given in English.

When the ingredients were given in Dutch, it did make some mistakes.

It also gave very basic ingredients when it was able to be creative and could add whatever ingredient to the recipe as desired.

Like other models, it didn't take dietary restrictions into account very well.

The implementation of Llama2 was harder compared to the other models because I had to rewrite the original prompt and make it easier and clearer because the original prompt was too complicated.

# Conclusion (DRAFT - Jonathan)

The things we've learned:

- Introducing AI into our codebase has enabled us to streamline or fully replace traditional solutions, eliminating the need for additional assets like large datasets. With proper configuration, AI proves to be a potent tool for various operations on (user-supplied) data.

- Throughout project development, we encountered variations in the ability of AI models to comprehend large and extensive prompts. Some models excel in certain tasks while lacking in others, emphasizing the importance of evaluating and selecting models based on application requirements.

- Consistency is key when parsing string responses from AI into Java objects.

# Our experience

Our internship journey culminated in the successful execution of our assignment.

Along the way, we encountered numerous challenges related to the project's implementation.

Moreover, it was genuinely an enriching learning experience. Engaging in a process filled with obstacles, and striving to overcome them, was profoundly educational.

This was made possible thanks to our experienced mentors and collegues, who provided invaluable assistance and knowledge throughout our journey.
