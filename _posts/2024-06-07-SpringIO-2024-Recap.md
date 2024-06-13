---
layout: post
authors: [maarten_casteels, wouter_nivelle]
title: 'Spring I/O 2024 - Recap'
image: /img/2024-06-07-spring-io-2024/header.jpg
tags: [springio, spring io, conference, spring]
category: Conference
comments: false
---
Our journey began with eight colleagues, including us, as we embarked on a trip from Brussels to Barcelona by plane. The excitement was noticeable, especially since we were leaving behind the gloomy Belgian weather for the sunny and vibrant atmosphere of Spain.

On Thursday morning, we woke up eager to attend the conference. With our registration tickets in hand, we headed to the venue and were warmly greeted by the volunteers at the registration desk. From that point, the conference truly began.

We want to thank [Sergi Almar](https://x.com/sergialmar) and his team for their excellent organization.

---

<img alt="The auditorium" src="{{ '/img/2024-06-07-spring-io-2024/auditorium.jpg' | prepend: site.baseurl }}" class="image fit" style="margin:0px auto; max-width: 750px;">

Our Maarten went a little bit beyond scope of the conference. He hasn't spammed every post with a reply, or created virtual and/or physical meetups during other conference talks. But an honest mention here was in place.

<img alt="Leaderboard" src="{{ '/img/2024-06-07-spring-io-2024/leaderboard.png' | prepend: site.baseurl }}" class="image fit" style="margin:0px auto; max-width: 750px;">

# Talks

* [Code Review](#code-review)
* [Tweaking Spring Security](#tweaking-spring-security)
* [Spring and Jakarta EE](#spring-and-jakarta-ee)
* [Spring Modulith](#spring-modulith)
* [Bootiful Spring Boot 3.x](#bootiful-spring-boot-3)
* [Introducing Spring AI](#introducing-spring-ai)
* [And many more](#and-many-more)

## Code Review
An honest talk about code review and how to deal with it came from [Paco van Beckhoven](https://x.com/DevPaco). The title made it clear from the start: _Cracking the Code Review: from Guesswork to Automated Guidance_. The presentation can be found [here](https://www.slideshare.net/slideshow/cracking-the-code-review-at-springio-2024/269479679).

The give aways:
- Say the good things too, because a review is already a bad environment
- As a creator don't blame when it takes time, but create friendly reminders
- Make sure your title and description our clear and well written, and provide a template to guide yourself and your environment
- Use tools and/or plugins to already strip away some of the comments
- But as a reviewer please take your time to review and when it has been taken offline mention the reasoning afterwards.

So most of it will be explained in the recording, but in this case you have some giveaways without listening and viewing it.

## Tweaking Spring Security
[Daniel Garnier-Moiroux](https://x.com/kehrlann) enlightened us on how to tweak Spring Security and what the next steps should be when using it. The path Spring Security has taken to structurize the configuration to let it make much more sense is a big win. The ease to add custom filters and knowing where to put them was my biggest take-away of the session.

## Spring and Jakarta EE
Why Spring Matters to Jakarta EE and Vice Versa was the talk that [Ivar Grimstad](https://x.com/ivar_grimstad) had forseen for Spring I/O. He explained the history of Jakarta EE and what the new features are in the upcoming release 11. The new feature is Jakarta Data 1.0 that had a great view on Spring Data. But then with less features to start, but it is a promising time. Another example is Spring Mail that is just a wrapper around Jakarta Mail. So fellow Spring developers, we can't ignore Jakarta EE.

## Spring Modulith
We followed multiple sessions about Spring Modulith, the first one was presented by [Cora Iberkleid](https://x.com/ciberkleid). She talked during the keynote about this topic and this session was a continuation. We learned how to start implementing Spring Modulith in a legacy application. Cora inspired our team to take a look, this was because of the automated documentation and the implementation of the Transactional Outbox Pattern.

Maciej Walkowiak's presentation and demo took a whole other approach on Spring Modulith by explaining what Aggregates, Value Objects, Repositories, Domain Events are.

From both of them we received much information and we're going to try to put them in practice in our projects.

## Bootiful Spring Boot 3
This talk was given [Josh Long](https://x.com/starbuxman) and was voted the most popular talk. We understand why! 

<img alt="Bootiful Spring Boot" src="{{ '/img/2024-06-07-spring-io-2024/bootiful.jpg' | prepend: site.baseurl }}" class="image fit" style="margin:0px auto; max-width: 750px;">

His first line was:
> There's never been a better time to be a Java and Spring Boot developer

He then goes into detail explaining what the new Java and Spring Boot features are, how they can be used, why they should be used (or not). All in his interesting, humorous style of presenting, it was great!

See the talk here on [Youtube](https://www.youtube.com/watch?v=2Aa5uQozbJQ).

## Introducing Spring AI
AI is all around us and becoming more and more important. Spring is giving us all the tools we need to use it ourselves! This session, given by [Christian Tzolov](https://x.com/christzolov) & [Mark Pollack](https://x.com/markpollack), introduces us to the wonderous world of Spring AI.

It learned us how to create effective AI prompts, including user-defined functions and how to convert AI responses into POJOs. But also how to use Vector Databases to store and retrieve your data.

## And many more
There were many talks, too many to follow them all. Luckily, they were all recorded and can be viewed on the [Spring IO Youtube Channel](https://www.youtube.com/playlist?list=PLe6FX2SlkJdQyqVIMrhYRYx-3KYDASifZ).

---

We want to close this adventure by thanking our company [Ordina](https://www.ordina.com/), a [Sopra Steria Company](https://www.soprasteria.com/), for letting us visit this awesome conference.

<img alt="Participants" src="{{ '/img/2024-06-07-spring-io-2024/participants.jpg' | prepend: site.baseurl }}" class="image fit" style="margin:0px auto; max-width: 750px;">