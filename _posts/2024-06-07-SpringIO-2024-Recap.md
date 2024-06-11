---
layout: post
authors: [maarten_casteels]
title: 'Spring I/O 2024 - Recap'
image: /img/springio.jpg
tags: [springio, spring io, conference]
category: Conference
comments: false
---
Our journey began with eight colleagues, including myself, as we embarked on a trip from Brussels to Barcelona by plane. The excitement was noticeable, especially since we were leaving behind the gloomy Belgian weather for the sunny and vibrant atmosphere of Spain.

On Thursday morning, we woke up eager to attend the conference. With our registration tickets in hand, we headed to the venue and were warmly greeted by the volunteers at the registration desk. From that point, the conference truly began.

We want to thank [Sergi Almar](https://x.com/sergialmar) and his team for their excellent organization.

---

Some space to add some random photos that are allowed for publication, and show off the venue?

One of our colleagues Maarten Casteels went a little bit beyond scope of the conference. He hasn't spammed every post with a reply, or created virtual and/or physical meetups during other conference talks. But an honest mention here was in place.
![[leaderboard.jpeg]]
`Palau de Congressos de Barcelona (Fira de Barcelona)`

---

Insert some interesting talks


An honest talk about code review and how to deal with it came from [Paco van Beckhoven](https://x.com/DevPaco). The title made it clear from the start: _Cracking the Code Review: from Guesswork to Automated Guidance_. __YOUTUBE LINK HERE__.

The give aways:
- Say the good things too, because a review is already a bad environment
- As a creator don't blame when it takes time, but create friendly reminders
- Make sure your title and description our clear and well written, and provide a template to guide yourself and your environment
- Use tools and/or plugins to already strip away some of the comments
- But as a reviewer please take your time to review and when it has been taken offline mention the reasoning afterwards.

So most of it will be explained in the recording, but in this case you have some giveaways without listening and viewing it.



Daniel Garnier-Moiroux enlighten myself on how to tweak Spring Security and what the next steps should be when using it. The path Spring Security has taken to structurize the configuration to let it make much more sense is a big win. The ease to add custom filters and knowing where to put them was my biggest take-away of the session.


Why Spring Matters to Jakarta EE and Vice Versa was the talk that Ivar Grimstad had forseen for Spring I/O. He explained the history of Jakarta EE and what the new features are in the upcoming release 11. The new feature is Jakarta Data 1.0 that had a great view on Spring Data. But then with less features to start, but it is a promising time. Another example is Spring Mail that is just a wrapper around Jakarta Mail. So fellow Spring developers we can't ignore Jakarta EE.


I followed a 2 sessions about Spring Modulith, the first one was presented by Cora Iberkleid. She talked during the keynote about this topic and this session was a continuation. We learned how to start implementing Spring Modulith in a legacy application. Cora inspired our team to take a look, this was because of the automated documentation and the implementation of the Transactional Outbox Pattern.

Maciej Walkowiak's presentation and demo took a whole other approach on Spring Modulith by explaining what Aggregates, Value Objects, Repositories, Domain Events are.

From both of them I had a blast of information and I try to put them in practice at my projects.

---

We want to close this adventure by thanking our company Ordina a Sopra Steria Company to letting us go it.