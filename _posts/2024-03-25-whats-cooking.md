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

- [Table of contents](#table-of-contents)
- [Introduction](#introduction)
- [Our Project](#our-project)
- [Application Architecture](#application-architecture)
- [Leveraging AI](#leveraging-ai)
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
The AI model must consider all user-provided recipe requirements and consistently format its responses.
Failure to do so could result in the AI model's responses being challenging to reliably parse into objects in a Java environment.

To address this issue there are two potential solutions.

The first approach entails creating a custom AI model, allocating sufficient resources, and training it to align with your specific use case.
Although the setup process may demand more time and resources, it could streamline prompt messages and decrease the number of tokens used in AI operations.

The second approach involves utilizing a standard AI model while supplying it with detailed prompt messages.
Using this method does not require complex training nor advanced configuration of AI models, allowing us to compare their out-of-the-box performance by providing the same prompt to different AI models.
Given that prompts are stateless, meaning there is no relation between previous or future prompts, we must furnish all necessary information, instructions, and context with each prompt.

To ensure proper formatting of the AI model's responses, we implemented a prompting technique known as <a href="https://www.promptingguide.ai/techniques/fewshot" target="_blank">Few-Shot Prompting</a>.
Essentially, with Few-Shot Prompting, you provide the AI model with an example question and answer from which it can discern a pattern.


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

|                | OpenAI ChatGPT                                                                                                                                                                                  | Amazon Titan                                                                                                                                           | Cohere Command                                                                                                                                                                                                                                   | Meta Llama2                                                                                                                                   |
| -------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------- |
| Strengths      | The model gives overal good responses, but requires explicit instructions when taking in account restrictions whilst generating the recipe.                                                                      | Overal good responses. Once configured it's consistent in its output in terms of formatting.                                                                                    | Easily adapts responses to a specific format (such as JSON).                                                                                                                                                                                                      | Reliably distinguishes between edible and inedible ingredients.                                                                          |
| Weaknesses     | Sometimes the JSON response is incorrectly generated. We noticed that the model generated recipes with inedible items. But when adjusting the prompt it did filter those items out. | Titan seems to have difficulties with elaborate prompts with lots of requirements and it can not resolve conflicting or unrealistic recipe requirements, for example a vegan recipe with meat.| Cohere doesn't understand Dutch names of ingredients and isn't secure in determining an ingredient's edibility. It also gives basic recipes even when it doesn't need to and doesn't take every diet or other preference into account. | Llama2 doesn't understand Dutch very well. It also gives very basic recipes and does often not take diets and other preferences into account. |
| Implementation | The implementation of OpenAI was a pleasant experience due to their excellent documentation.                                                                                                             | Implementing Titan was not a linear process and involved excessive trial-and-error.                                             | Easy ingredient implementation, difficult recipe implementation.                                                                                                                                                                                     | Difficult implementation of both prompts.                                                                                                         |

### OpenAi ChatGPT

Our experience with OpenAI's generative language model has been largely positive, marking one of our first successful interactions with advanced AI for content creation. 
The ease of integration and the comprehensive support provided have been standout features. 
However, it's important to note that while the model excels in many areas, there were instances where it fell short of our specific needs. 
This acknowledgment isn't a dismissal but an insight into what we thought that the model couldn't acheive concidering our requierments and expectations.

However, as with any complex AI system, the nuances of human language and the subtleties of specific requests can sometimes present challenges. For instance, while the model is generally adept at adhering to guidelines and generating safe and appropriate content, there have been instances where the outputs, such as recipes, inadvertently included toxic or non-edible items. 
Remarkably, adjusting the prompt has shown to effectively mitigate this issue, underscoring the importance of precise and thoughtful prompt engineering to guide the model's responses more accurately.

One area that has proven particularly challenging involves the generation of content that adheres strictly to dietary preferences or restrictions. 
A notable example includes the model's unexpected difficulty in producing vegan recipes without including animal products like "Pork belly." This occurrence suggests a need for further refinement in the model's understanding and categorization of ingredients in relation to specific dietary guidelines. 
Additionally, the model's approach to generating lactose-free recipes, by substituting with "lactose-free" options, raises questions about its ability to navigate the nuances between different dietary requirements accurately.

### Amazon's Titan

AWS Titan in its current stage is an AI model that is difficult to finetune using Few-Shot Prompting.
Prompt instructions are often not reflected in the output making the implementation of Titan in your application time consuming.
Without correctly configuring the model its output is extremely inconsistent in terms of structure, making its integration in an OOP environment a liability.

Once set up to consistently format its responses in JSON, we focus on the content of the recipes.
Titan outputs recipes which range from delicious to impossible, such a vegan dish with meat.

In conclusion, Titan is a viable option if you're looking for an AI-model to use with Few-Shot Prompting. It's able to provide additional solutions although the actual implementation process is tedious. 

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
The original prompt of the OpenAI model was too complicated for Llama2

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
- 
### Infrastructure

- **Terraform:** An infrastructure as code software tool that allows you to build, change, and version infrastructure safely and efficiently.

### AI Models

- **Image Generation**: Dall-e.

- **Text-To-Speech Generation**: Amazon Polly.

- **Large Language Models**: OpenAI ChatGPT, Amazon Titan, Cohere Command, Meta LLama2.

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

Finally, throughout our project development, we encountered variations in the comprehensiveness of AI models.
While certain models shine in particular tasks, they may falter in others.
This highlights the importance of thorough evaluation and selective criteria based on the application's specific requirements.
