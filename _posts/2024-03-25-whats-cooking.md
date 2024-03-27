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
- [Architecture](#architecture)
- [Leveraging AI (DRAFT - Jonathan)](#leveraging-ai-draft---jonathan)
- [AI Benchmarking](#ai-benchmarking)
- [Conclusion (DRAFT - Jonathan)](#conclusion-draft---jonathan)

# Introduction

To align with the new trend of generative AI models we created What'sCooking which is an application where users can easily extract their shopping basket items with a click. These items undergo analysis by advanced AI, which then suggests personalized recipes based on the user's inventory. The AI filters the ingredients to ensure the suggestions align with the user's preferences.

The purpose is to test the usage of AI that generates new human-readable content rather than finding or classifying existing content. This falls under the category of LLMs. More explanations about this will be provided in upcoming sections. Furthermore, the purpose of Prompt Engineering and how it can make a big difference when tweaking communication with a large chat model will be discussed.

The application doesn't stop at recommendations; it dynamically generates images of suggested recipes. Users can also personalize their experience on the Preferences page, specifying dietary restrictions and culinary preferences. Powered by LLM, generative AI, and AWS for deployment, the app is at the forefront of innovation. Continuous updates ensure optimization of pricing, performance benchmarking, and accommodation of diverse user requests.

# Architecture

# Leveraging AI (DRAFT - Jonathan)

In our application, the backend receives data delivered by the Chrome plugin via HTTP request.
It performs various operations on this data, most of them involving AI.

The first AI-operation is cleaning the data of undesired elements.
In our case this means filtering out the inedible ingredients from a collection of potentially edible ingredients. Without AI, handling this problem would require accessing a large dataset and executing multiple queries. Whereas in our application this entire process was replaced by a single prompt and handling of the response.
It even appears the AI has perfect judgement on whether something is safe for human consumption, and it is more stubborn than you would expect when you try to convince it otherwise.

With this potentially altered list of ingredients we can proceed to our second AI-operation, which boils down to generating content in the shape of a recipe.
The AI model should take into account all the recipe requirements, and format its replies in a consistent & specific way.
Otherwise we run the risk of the AI-model's responses not being able to be reliably parsed into objects in a Java environment.

There are two main approaches to ensure consistency:

- Custom AI Model: Develop a tailored AI model, requiring more initial investment but offering precise alignment with your needs.

- Standard AI Model with Elaborate Prompts: Utilize a pre-existing AI model, supplementing it with detailed prompts to assess its performance out-of-the-box.

While the prompts are stateless, meaning each prompt is self-contained and does not rely on previous interactions, we must provide all necessary instructions and data for each prompt. Despite the greater token efficiency of the first approach on a prompt-to-prompt basis, we opted for the second approach. This allows us to conveniently compare the performance of AI models by supplying them with the same prompt, facilitating our benchmarking and study.

To ensure proper formatting of the AI-model's replies we implemented a prompting technique called "Few-Shot Prompting".
Simply put, with Few-Shot Prompting you provide the AI model an example question & answer out of which it can establish a pattern.
For this approach we engineered a template to serve as a basis for our prompt, in which we inject the dynamic information before sending it to the AI.

# AI Benchmarking

# Conclusion (DRAFT - Jonathan)

AI has demonstrated its potential as an invaluable addition to any software application.

One thing that became evident in an OOP environment is that when parsing String responses from the AI model into objects consistency is paramount.
This consistency ensures seamless integration and reliable functionality within our application.

Finally, it's worth noting that during our project development we've encountered variations in the comprehensiveness of AI models.
Some models excel in certain tasks while lacking in others, highlighting the importance of evaluation and selection based on the application requirements.
