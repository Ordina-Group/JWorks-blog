---
layout: post
authors: [frederick_bousson, kevin_van_den_abeele]
title: "The Vuzix Blade"
image: /img/2019-03-31-vuzix/banner.jpg
tags: [Internet of Things, Augmented Reality, Virtual Reality, Smart tech, Smart glasses, Android, Vuzix, Vuzix Blade, CES, Consumer Technology Association]
category: IoT, Smart tech, Smart glasses, Augmented reality
comments: true
---
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.9.0/css/lightbox.css" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-grid-only@1.0.0/bootstrap.css" />

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.9.0/js/lightbox.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap-grid-only@1.0.0/index.min.js"></script>

## Table of Contents

1. [Introduction](#introduction)
2. [The hardware](#the-hardware)
3. [The software](#the-software)
4. [Using the Vuzix](#using-the-vuzix)
5. [Developing for the Vuzix](#developing-for-the-vuzix)
6. [Looking forward](#looking-forward)
7. [Resources](#resources)

## Introduction

As we are strong believers about the impact that Augmented Reality will have in a business setting, we were eager to get started building things. 
But this required getting our hands on some actual hardware!
We acquired some budget and went looking for 'affordable' smart glasses to experiment with.

We were following the Vuzix for quite some time as they seemed market leader in wearable head-mounted technology. The type of devices they were producing didn't have the coolness factor we were hoping for.

And along came the Vuzix Blade... This looked like a real game changer. Something someone would actually wear on their face!

<div class="responsive-video">
    <iframe width="1164" height="655" src="https://www.youtube.com/embed/V-OxzjsB2s0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
</div>
<br/>

It was a video like this one that had won us over to give the Vuzix Blade a try since the displayed features look very nice, if they all worked as promised...

After a long wait we finally got our hands on a pre-production hand-built Vuzix Blade and joined the Edge Developer Program.
We got these glasses to analyze the wearers experience and see how we could integrate it into the numerous business cases:


- Assistance for field technicians
- Order picking
- Communications platforms

In this blogpost we'll go a bit into detail what makes the Vuzix Blade tick and how our experience with it has been so far.
Read on ahead for all the juicy details!

## The hardware

<img alt="Vuzix Blade hardware overview" src="{{ '/img/2019-03-31-vuzix/vuzix-hardware-overview.jpg' | prepend: site.baseurl }}" class="image fit" style="margin:0px auto; max-width: 800px;">

The Vuzix Blade is essentially an Android smartphone you can wear on your face.
Well actually, it's really more like an Android smartwatch you can strap to your face, but you get the idea.

The device we received was a pre-production build, which was assembled by hand.
This means we can't really say much about what the final hardware will look like, if there will be any changes or if the build quality, which was very solid, will change.
During our testing it has been through some light and heavy action: like daily commute use, office use, running, biking, etc, and still hasn't shown any faults or cracks.


We've always found the idea of computing devices in the form factor of glasses quite intriguing as some of us have been cursed with nearsightedness and already have to wear prescription glasses.

If we have to wear the bloody things every day, might as well put some intelligence into them.

Below you can find some specs about the device, but for us these are quite irrelevant for the moment.
This device is all about showcasing innovation in two areas: form factor and display technology.

And boy are we impressed.
The glasses actually feel comfortable enough to wear for longer periods and the display technology is quite amazing! 
It's nowhere near the HoloLens, but they serve a completely different purpose.

Let's get down the mandatory spec overview!
The internals inside the glasses are alright, maybe a bit underwhelming.
Knowing it's always a fine line to balance between power consumption and battery life, the internals inside the glasses are alright, maybe a bit underwhelming.

- Projected display resolution of 480 by 853 pixels
- Quad core ARM A53 CPU
- WiFi, Bluetooth
- 8MP camera up to 1080p video recording
- 470mAh battery

The amount of RAM is not specified but seems to be just the right amount to get the job done.

Overall the device works fine for normal apps but the speed and fluidity could be better for some high-end apps (1080p video capture, TensorFlow Lite, ...)

There is no audio on the device as no regular or bone conducting speaker is present.
Audio can be provided through either Bluetooth or USB audio, but an included speaker would have been nicer.
Initially the video recording only supported up to 720p at a lower frame rate, which with the lack of OIS was not very usable in high motion scenarios.
However, the latest software update added support for 1080p recording and as you can see in one of the videos down below is actually acceptable.

All of this is actually quite irrelevant to us.
There is no innovation in fitting a better camera or having oodles of computing power on the device.
The technological marvel in this device is the display technology, named the `Cobra Display Engine`.

<img alt="Vuzix Blade hardware overview" src="{{ '/img/2019-03-31-vuzix/ui1.jpg' | prepend: site.baseurl }}" class="image fit" style="margin:0px auto; max-width: 800px;">

It's difficult to explain how well this works.
So we'll just rip off the movie "Contact" and say:
> No words to describe, they should have sent a poet.
> So beautiful! I had no idea.

The best description we could think of so far is:
It's like someone is following you from behind with a projector and is projecting the user interface on an invisible screen in front of you.
Hold a smartwatch right in front of you in a readable position.
It's kinda like that, but transparent and without losing the functionality of one of your arms.


So instead of describing it to people, we just put it on their head and they were just immediately captivated by what they're experiencing.
It takes a moment to learn how to switch your eyes' focus on the heads up display and back to your surroundings.
Once you master this it becomes very natural to interact with the display, however staring at it for prolonged periods is not what's it's meant for.
A lot of people have difficulty in wrapping their heads around the idea of that transparent interface when trying out the glasses for the first time.
After this we show them some pretty pictures with a variety of colors.
This really shows off the unexpectedly good visual qualities of the display and brings everything to life!

For a concept device it really shows what the technology is capable of.
We do hope that the final hardware specs will be a bit more beefy. 
Imagine running TensorFlow lite object detection in full force on the device. So many cool things we could do with computer vision!

Adding a sim card slot and a GPS chip would also be awesome, since this would allow us to autonomously use the glasses without a companion smartphone. 
This would allow us completely sever the link to the companion smart phone.


## The software

The Vuzix Blade runs on Android 5.1.

Due to the limited screen real estate of the device, the look and feel of the apps reminds us a lot of smartwatch apps.

There aren't many out-of-the-box apps on the device installed:

- Welcome dashboard
- Camera
- Gallery
- Music control
- Settings

One of the most important features of wearables is notification mirroring, which works out-of-the-box.

With the Vuzix Blade also comes a [companion app](https://play.google.com/store/apps/details?id=com.vuzix.companion){:target="_blank" rel="noopener noreferrer"} for your Android or iOS Smartphone.

This companion app allows you to configure settings, fetch images and videos from the device, manage installed apps and explore the Blade app store.

<img alt="Vuzix Blade hardware overview" src="{{ '/img/2019-03-31-vuzix/vuzix-app.png' | prepend: site.baseurl }}" class="image fit" style="margin:0px auto; max-width: 650px;">

As this device doesn't run the Google Play Store, a specific app store is needed.
[This app store](https://www.vuzix.com/appstore?deviceFilter=blade){:target="_blank" rel="noopener noreferrer"} allows Vuzix specific apps to be installed on the device.

<div style="text-align: center; margin: 0px auto;">
    <a href="{{ '/img/2019-03-31-vuzix/ui3.jpg' | prepend: site.baseurl }}" data-lightbox="ui" data-title="QR Scanner UI">
        <img alt="stack" src="{{ '/img/2019-03-31-vuzix/ui3.jpg' | prepend: site.baseurl }}" class="image fit" style="margin:0px auto; width: 49%; display: inline-block;">
    </a>
     <a href="{{ '/img/2019-03-31-vuzix/ui2.jpg' | prepend: site.baseurl }}" data-lightbox="ui" data-title="Our custom Polar Watch heart beat app">
        <img alt="stack" src="{{ '/img/2019-03-31-vuzix/ui2.jpg' | prepend: site.baseurl }}" class="image fit" style="margin:0px auto; width: 49%; display: inline-block;">
    </a>
</div>
<br/>

<div style="text-align: center; margin: 0px auto;">
    <a href="{{ '/img/2019-03-31-vuzix/ui-anim1.gif' | prepend: site.baseurl }}" data-lightbox="ui-anim" data-title="Home menu with animation">
        <img alt="stack" src="{{ '/img/2019-03-31-vuzix/ui-anim1.gif' | prepend: site.baseurl }}" class="image fit" style="margin:0px auto; width: 49%; display: inline-block;">
    </a>
     <a href="{{ '/img/2019-03-31-vuzix/ui-anim2.gif' | prepend: site.baseurl }}" data-lightbox="ui-anim" data-title="AR application">
        <img alt="stack" src="{{ '/img/2019-03-31-vuzix/ui-anim2.gif' | prepend: site.baseurl }}" class="image fit" style="margin:0px auto; width: 49%; display: inline-block;">
    </a>
</div>
<br/>

## Using the Vuzix

The thing we like about the Blade is how comfortable it is to wear compared to other head-mounted wearable solutions like the HoloLens.
The HoloLens is quite heavy and in our opinion not meant to be worn all day long. 
The Blade however is light enough to stay comfortable for long time wearing.

Although Vuzix targets the Blade partially at the consumer market, we believe that there is much more potential in the enterprise market.
Let's hope they don't make the same mistake Google made with Google Glass!

But because they also target the consumer market, they thought about very important things like ergonomics and making it look appealing enough for non techies.

<div style="text-align: center; margin: 0px auto;">
    <a href="{{ '/img/2019-03-31-vuzix/wear1.jpg' | prepend: site.baseurl }}" data-lightbox="wearing" data-title="Wearing the Vuzix Blade 1">
        <img alt="stack" src="{{ '/img/2019-03-31-vuzix/wear1.jpg' | prepend: site.baseurl }}" class="image fit" style="margin:0px auto; width: 55%; display: inline-block;">
    </a>
    <a href="{{ '/img/2019-03-31-vuzix/wear2.jpg' | prepend: site.baseurl }}" data-lightbox="wearing" data-title="Wearing the Vuzix Blade 2">
        <img alt="stack" src="{{ '/img/2019-03-31-vuzix/wear2.jpg' | prepend: site.baseurl }}" class="image fit" style="margin:0px auto; width: 24%; display: inline-block;">
    </a>
    <a href="{{ '/img/2019-03-31-vuzix/wear3.jpg' | prepend: site.baseurl }}" data-lightbox="wearing" data-title="Wearing the Vuzix Blade 3">
        <img alt="stack" src="{{ '/img/2019-03-31-vuzix/wear3.jpg' | prepend: site.baseurl }}" class="image fit" style="margin:0px auto; width: 17.5%; display: inline-block;">
    </a>
</div>
<br/>

Our colleague, Frederick tested the device for a longer period of time:
>
> Sometimes I wear this device for a full day to get deeply immersed in the experience.
> As it is comfortable to wear, this wasn't much of an issue.
>
> My first experiment was to check how many would look funny at me during my morning commute.
> The good news is that during my train ride and walk around the office, not many people were or kept staring at me.
> However, the people that knew me asked what I had on my face.

<div class="responsive-video">
    <iframe width="1164" height="655" src="https://www.youtube.com/embed/lAiAl370BA8" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
</div>
<br/>

The interaction models are quite straightforward.
It's a good platform to consume push content.
Your screen lights up, you get your info, the screen dims.

If you want to actually interact with the app, you can use the touchpad located near your right temple.
Using gestures like:

- Swipes
  - Up
  - Down
  - Left
  - Right
- Two finger swipes
- Tap
- Double tap
- Long tap
- etc

Again, very similar to smartwatches.

Support for Amazon Alexa is currently in a Beta program for which we've signed up.
Really wondering how natural this voice interaction will be!

As we said before, some of us wear glasses and the Blade display is readable when you have only minor nearsightedness, but the display is much sharper when you put the Blade on top of your regular glasses.
For an additional markup it is possible to get prescription lenses with the Blade so people who wear glasses on daily basis can also use this device.

Battery life is very much inline with smart watches: it all depends on the usage.
We can easily keep an app running with the screen on for almost two hours.

If you are only consuming (push) notifications it's possible to stretch this to a full day.
For longer and more intensive usage an external battery pack is a must.
Luckily it's quite non-intrusive to equip a battery pack by using the USB port located on the side.
Once you do this, battery life is not an issue anymore.
We did some testing and actually went running and cycling while wearing an external battery pack and did not experience any hinder at all.

## Developing for the Vuzix

Developing for the Blade is just like developing for any Android device.
You just develop in Android Studio, like you would normally do.
This means Vuzix can leverage the huge amount of Android devs out there.
Our Android devs found the learning curve to be relatively low.

You do need to take into account that the Blade comes with its own design guidelines and UI components.
The interaction model and how apps are structured is quite elegant and straightforward, no surprises here!
Just import two Blade specific libraries with the components and you're good to go.
No other dependencies are needed!

There is no Blade emulator available, but Vuzix has added support for the Android Studio design view.
Although the layout of most screens will be very basic, it was still very handy to quickly prototype UIs.

We brainstormed a bit about what would be a good app to leverage the innovative aspects of the Blade.
As Frederick was recently training to regain his once athletic body, he bought a Polar H10 heart rate sensor which can connect to a smartphone using Bluetooth Low Energy (BLE).

A lot of runners already have smartwatches to monitor their heart rate. 
Some of these watches even vibrate when you're not running in the correct heart rate zone.
More info on heart rate zones can be found [here](https://support.polar.com/en/support/tips/Polar_Sport_Zones){:target="_blank" rel="noopener noreferrer"}.

A lot of runners already have smartwatches to monitor their heart rate. Some of these watches even vibrate when you're not running in the correct [heart rate zone](https://support.polar.com/en/support/tips/Polar_Sport_Zones){:target="_blank" rel="noopener noreferrer"}.


Although runners already have access to this information on their smart watch, it's not the best form factor to consume the data. Ever tried reading your watch while running and bouncing around at 10+ km/h? 
Having to shift your focus like this just completely gets you out of "the zone". 

We thought this was a good showcase of the capabilities of the Blade: easily consume the information you need, enabling you to make the best decisions, while being as non-intrusive as possible. 


Because Polar implements the official Heart Rate device specification it was very straightforward to set up a BLE connection between the sensor and the Blade.
Every second or so the BLE device pushes an update of the current heart rate to the BLE client.

After tapping into this stream of sensor data, it wasn't too difficult to build the app.
Currently we only display the current time, heart rate and heart rate zone.

The video below showcases the app.
The user interface is still very minimalistic and the app itself is still a work in progress.
However, it's already very functional.

<div class="responsive-video">
    <iframe width="1164" height="655" src="https://www.youtube.com/embed/FzUgWBVQCS8" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
</div>
<br/>

The video doesn't do the app justice as you don't get to experience the transparent display, allowing you to see the world around you.
Seeing those numbers and letters float in open air is always a joy to see.

While experimenting with new technologies, we prefer to use the Minimal Viable Product (MVP) approach: focus on what brings most value and then validate this as soon as possible.
This also means field testing the concept in the most representative and harsh environment you can think off.

So, Frederick ventured forth to a place where not many developer dare venture: outdoor in the sun.

Everyone who has ever worked with a laptop, smartphone or tablet outside can agree that the readability of these screen drops to zero as on bright and sunny days.
The Blade solves this by having a very bright display. Apps also use the following two tricks to optimize readability:  

- Use high contrast colors, like green.
- Dynamically make the transparent part of display white to increase the contrast even more.

Frederick took the Blade on a 10km run to validate if the app was usable, readable and useful... And it sure was!
Seeing your live heart rate gives you a lot of insight into your performance. 
It also turns everything into a game: Can I do better? How long can I keep going at this pace?
The glasses were comfortable enough to wear for the full run. And most importantly: the batteries didn't run out!

All in all, it was such a positive experience that Frederick found it difficult to go running without these glasses.

<img alt="Vuzix Blade Heart rate testing" src="{{ '/img/2019-03-30-vuzix/run.jpg' | prepend: site.baseurl }}" class="image fit" style="margin:0px auto; max-width: 800px;">

We have sent a demo to the people of Vuzix and they were also very enthusiastic about the concept.
We will now polish the app a bit more to make it consumer friendly and then publish it to the Vuzix app store.

In a future version of the app, we would like to add things like:

- Average heart rate
- Max heart rate
- Calories burned

With the latest software upgrade we can also tap into the GPS data from the smartphone via the companion app.
This will allow us to also display things like: current speed, max speed, average speed, distance travelled, etc.

It will be an interesting challenge getting all this data on the rather small display.
This is something we will probably outsource to our UX / UI wizkids over at [ClockWork](https://clockwork.ordina.be/){:target="_blank" rel="noopener noreferrer"}.

## Looking forward

What we got with the Vuzix Blade looks already very promising even though there are a few small rough edges.
Vuzix keeps rolling out significant software updates for the device that open up new possibilities.

It is not unthinkable that devices like this will become common consumer electronics if you see what [Focals by North](https://www.bynorth.com/){:target="_blank" rel="noopener noreferrer"} are.
But certain hurdles still have to be taken such as making them look even more appealing to everyday users.
[Focals by North](https://www.bynorth.com/){:target="_blank" rel="noopener noreferrer"} is already taking a nice step in this direction. They however do this by sacrificing certain features (no camera, integrated touchpad, SD-card slot, ...) which we think are important for enterprise user.
As such, we still see the Vuzix Blade as best in breed.

The better battery technology that is just around the corner could also prove to be a total game changer for wearable devices. 
Imagine your glasses as an all day long companion, augmenting all your senses and feeding you with on the spot contextual information.

We do not believe this device will ever be direct competition to the Microsoft HoloLens as they serve 2 different purposes at a completely different price point.
Would €500 be a good enough price point to appeal to the general public? 
Would this cost be low enough to have companies build positive business cases to equip their technicians with Augmented Reality / Assisted Reality devices?

Let's hope so!

## Resources

- [Vuzix Blade Smart Glasses](https://www.vuzix.com/products/blade-smart-glasses){:target="_blank" rel="noopener noreferrer"}
- [Vuzix product videos](https://www.vuzix.com/products/Videos){:target="_blank" rel="noopener noreferrer"}
- [Vuzix app store](https://www.vuzix.com/appstore?deviceFilter=blade){:target="_blank" rel="noopener noreferrer"}
- [Microsoft HoloLens 2](https://www.microsoft.com/en-us/hololens/buy){:target="_blank" rel="noopener noreferrer"}
