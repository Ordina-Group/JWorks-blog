---
layout: post
authors: [ayoub_ait_cheikh_ahmed, jonathan_moermans]
title: "Automate note taking with this simple tool"
image: /img/2024-05-17-transcribe/transcribe-banner.jpg
tags: [AI, aws, internship, transcribe]
category: Internship
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
This saves you the time and effort of manually transcribing and distributing meeting notes.
It's our goal to make the user experience as convenient as possible, so we designed our user interface to be intuitive and minimalistic.
Recording audio is possible under the "Audio"-tab, and supplying all other necessary data is possible through a simple form under the "Data"-tab.

<img alt="Transcribe example output" src="/img/2024-05-17-transcribe/transcribe-gui.png" class="image fit">

Once the recording is submitted, the audio is automatically processed, transcribed, and summarized before being sent to the designated recipients. 
To see this in action, check out the following example of an AI-generated recording:

<img alt="Transcribe example output" src="/img/2024-05-17-transcribe/transcribe-example-output.png" class="image fit">

# Application Flow

In our application we make good use of various Amazon Web Services to handle your request.

Our primary tool is AWS Transcribe, converting audio recordings into text transcripts.
One of Transcribe's most powerful features is Automatic Speech Recognition, enabling us to support transcription in over [over 100 languages](https://docs.aws.amazon.com/transcribe/latest/dg/supported-languages.html){:target="_blank" rel="noopener noreferrer"}.

Additionally, with AWS Transcribe you can enhance your transcriptions with specialized services at an extra cost.
For instance, [Transcribe Call Analytics](https://aws.amazon.com/transcribe/call-analytics/){:target="_blank" rel="noopener noreferrer"} provides metrics on customer service phone calls, and [Transcribe Medical](https://aws.amazon.com/transcribe/medical/){:target="_blank" rel="noopener noreferrer"} is tailored for medical terminology and automatic redaction of sensitive patient data.

To summarize these transcripts we use AWS Bedrock, specifically leveraging the Amazon Titan Text AI-model. 
Titan is a cost-efficient generative AI model, which excels in text processing.
Our interaction with this model is straightforward: we input the transcript into the prompt and request a concise summary.

After we have our full and summarised transcription, we deliver it per e-mail to our user's inbox using AWS Simple Notification Service.

<img alt="Transcribe application flow" src="/img/2024-05-17-transcribe/transcribe-application-flow.png" class="image fit">

# Future improvements

During the transcribe project internship we came across several potential enhancements or features that could be implemented if the time was available. 
Several points that could be improved or added, such as the following:

- E-mail customization: Customise the content received
- Live transcription: Real-time conversation subtitling
- Integrating with existing chat applications