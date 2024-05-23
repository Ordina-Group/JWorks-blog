---
layout: post
authors: [ayoub_ait_cheikh_ahmed, jonathan_moermans]
title: "Transcribe"
image: /img/2024-05-17-transcribe/transcribe-banner.jpg
tags: [AI, aws, internship, transcribe, terraform]
category: AI
comments: true
---

# Project Transcribe

We can best introduce our internship project by its purpose: making your daily work life easier.
And how would it do so?
Let's assume you are the average consultant at Sopra Steria.
Then you probably have multiple meetings per week, if not multiple meetings per day.
We, at team Transcribe, believe you should pay full attention to the topics being discussed, and you shouldn't be taking notes or write anything down at all.
So we developed a software application that does that for you.

# What Transcribe does for you

In a nutshell, our application takes an audio recording and transforms that into a summarized briefing which it delivers to you by e-mail.
In its current stage our application allows you to record audio from your web-browser.
Once the recording is complete, it is automatically processed, transcribed, and summarized before being sent to the designated recipients.

The following is an example, which we received after submitting an AI-generated recording:

<img alt="Transcribe example output" src="/img/2024-05-17-transcribe/transcribe-example-output.png" class="image fit">

# Application Flow

We utilize two powerful AI tools from AWS to enhance our transcription and summarization capabilities.  

AWS Transcribe: This is our primary speech-to-text tool, converting audio recordings provided by users into text transcripts. It ensures accurate and efficient transcription of spoken words into written form. 

AWS Bedrock: For summarizing these transcripts, we use AWS Bedrock, specifically leveraging Amazon Titan. Titan is an advanced AI model trained in text processing. Our interaction with this model is straightforward: we input the transcript into the prompt and request Titan to generate a concise summary for us. 

<img alt="Transcribe application flow" src="/img/2024-05-17-transcribe/transcribe-application-flow.png" class="image fit">

# Future improvements

During the transcribe project internship we came across several potential enhancements or features that could be implemented if the time was available. 
Several points that could be improved or added, such as the following:

- E-mail customization: Customise the content received
- Live transcription: Real-time conversation subtitling
- Integrating with existing chat applications