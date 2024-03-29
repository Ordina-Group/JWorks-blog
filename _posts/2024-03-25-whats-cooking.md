---
layout: post
authors: [ayoub-ait-cheikhahmed, jonathan, febe]
title: "Whats Cooking AI"
image: /img/2024-03-25-whatscooking/whatscooking-banner.jpg
tags: [AI, aws, internship, springAI, terraform, docker]
category: AI
comments: true
---

# Table of contents

- [Table of contents](#table-of-contents)
- [Introduction](#introduction)
- [Our Project (DRAFT - Febe)](#our-project-draft---febe)
- [Application Architecture (DRAFT - Febe)](#application-architecture-draft---febe)
- [Leveraging AI (DRAFT - Jonathan)](#leveraging-ai-draft---jonathan)
- [AI Benchmarking](#ai-benchmarking)
- [Conclusion (DRAFT - Jonathan)](#conclusion-draft---jonathan)

# Introduction

To align with the new trend of generative AI models we created What'sCooking which is an application where users can easily extract their shopping basket items with a click. These items undergo analysis by advanced AI, which then suggests personalized recipes based on the user's inventory. The AI filters the ingredients to ensure the suggestions align with the user's preferences.

The purpose is to test the usage of AI that generates new human-readable content rather than finding or classifying existing content. This falls under the category of LLMs. More explanations about this will be provided in upcoming sections. Furthermore, the purpose of Prompt Engineering and how it can make a big difference when tweaking communication with a large chat model will be discussed.

The application doesn't stop at recommendations; it dynamically generates images of suggested recipes. Users can also personalize their experience on the Preferences page, specifying dietary restrictions and culinary preferences. Powered by LLM, generative AI, and AWS for deployment, the app is at the forefront of innovation. Continuous updates ensure optimization of pricing, performance benchmarking, and accommodation of diverse user requests.

# Our Project (DRAFT - Febe)

For our internship project, we developed "What's Cooking with ChatGPT." This entails a Chrome extension designed to suggest AI-generated recipes based on the items currently residing in the user's online shopping basket. To achieve this, we crafted scrapers specifically tailored to extract data from popular Belgian webshops such as Colruyt, Delhaize, Albert Heijn, and Aldi.

Within our Java backend, we seamlessly integrated Spring AI, facilitating the implementation of various AI models including OpenAI's ChatGPT and Amazon's Titan. For the frontend, we utilized React and Next.js to craft the interface of our extension.

Initially, our project featured a straightforward interface solely displaying the generated recipe. Subsequently, we enhanced this interface to offer users the ability to personalize their experience by selecting preferences such as dietary or culinary restrictions. These preferences serve to tailor the recipe recommendations to the individual user. Additionally, we incorporated functionality enabling the generation of a reference photo depicting the suggested recipe. Furthermore, users can export recipes to a text file for future reference and use.

# Application Architecture (DRAFT - Febe)

In our project, we implemented CI/CD to streamline the deployment process of our backend. This was achieved by leveraging various tools offered by different providers such as GitHub and Amazon Web Services (AWS). Initially, we began by writing workflow files to automate the execution of tests with each push to the development branch on GitHub. Over time, this progressed into developing workflow files aimed at building and deploying our backend onto App Runner, thereby enabling seamless access to our backend without the necessity of local execution.

Within our GitHub workflow files, we designed jobs dedicated to constructing Docker images using Maven, facilitating the subsequent pushing of the latest backend image to Amazon Elastic Container Registry (ECR). Following the image push to ECR, we employed Terraform to deploy this image onto App Runner. To streamline the orchestration of these jobs, which were authored in separate files for organizational clarity, we utilized a main workflow file to dictate the sequence in which the jobs were to be executed.

In our pursuit of enhancing backend security on App Runner, we opted to integrate an API Gateway. This gateway serves as a protective layer, mandating that all frontend requests transit through it and ensuring access to the backend only if the appropriate key is present in the request headers.

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

<!-- WIP -->

# Conclusion (DRAFT - Jonathan)

The things we've learned:

- Introducing AI into our codebase has enabled us to streamline or fully replace traditional solutions, eliminating the need for additional assets like large datasets. With proper configuration, AI proves to be a potent tool for various operations on (user-supplied) data.

- Throughout project development, we encountered variations in the ability of AI models to comprehend large and extensive prompts. Some models excel in certain tasks while lacking in others, emphasizing the importance of evaluating and selecting models based on application requirements.

- Consistency is key when parsing string responses from AI into Java objects.
