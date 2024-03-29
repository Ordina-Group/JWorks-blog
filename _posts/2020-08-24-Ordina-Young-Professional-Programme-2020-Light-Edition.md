---
layout: post
authors: [hannelore_verbraekel, pieter_van_overbeke, eduard_tsatourov, youri_vermeir]
title: "Ordina Young Professional Programme 2020 Light Edition"
image: /img/kicks.png
tags: [Spring, Spring Boot, Angular, Unit testing, Mocking, Cloud-Native, Git, DevOps, Docker, TypeScript, Kickstarter, Young Professional Program, Security]
category: Young Professional Programme
comments: true
---
<style>
    .image.left {
        margin: 0;
    }
</style>

# Introduction
The Young Professional Programme is made for starting developers who want to take their skills to the next level. 
This year, the light edition started on the 9th of March 2020 and lasted for about 3 months. 
We started with 4 junior developers. 
Youri was freshly graduated from school, while Eduard, Pieter and Hannelore had professional experience in IT.
Every one of us is mainly interested in front end web development by sheer coincidence.
In the first month of the Young Professional Programme we followed different workshops about the preferred stack used at Ordina. Sadly, about a week in, our sessions were held remotely due to the coronavirus. 
This made things more complicated, but because of the flexibility and effort of the mentors, 
the sessions were still clear and educational. 

# Setup
The first few days of our training were centered around building a base for the upcoming weeks. 
Since we all just got our laptops the day before we didn't have anything installed on them 
so that was the focus on the first training day.
We got the chance to install all programs and tools required for the rest of our training, 
like Docker, Visual Studio Code, IntelliJ, Git,...
A variety of different editors and IDEs were shown and we were allowed to pick the ones we preferred.

# Git
<img class="image left small" alt="Git logo" src="/img/2020-03-31-Young-Professional-2020-Light/git.png">

We also had a session about Git which is obviously an essential tool to understand for any modern developer. 
We saw the ins and outs of most of the Git commands and we practiced the most common ones. 
We didn't just see Git but also how it came to be and its predecessors. 
Overall, it was an interesting session giving us a decent understanding of Git.


# Back end
### Java
<img class="image right medium" alt="Java logo" src="/img/2020-03-31-Young-Professional-2020-Light/java.png">

Java is a general-purpose programming language that was released in 1995, which means it has been around for 25 years. 
It has become very popular over these years. In 2019, Java was one of the most used programming languages according to Github.
Java is also the preferred back end language of JWorks. 
Yannick De Turck gave us a workshop around this programming language. 
We talked about the new features that were released with each version from Java 7 until 14. 
In between the theory lessons we made some hands-on exercises on the new features like lambdas, streams and optionals. 
This was also the last day before the corona outbreak in Belgium. 
This meant the rest of the Young Professionals Programme was given remotely. 


### Spring

<img class="image left medium" alt="Spring logo" src="/img/2020-03-31-Young-Professional-2020-Light/spring.png" >

The Spring framework is an application framework and inversion of control container for the Java platform. 
It has become wildly popular in organizations and the Java community. 
We followed a three-day self study course, where we read the book 'Spring in action' by Craig Walls. 
This book gives you a general understanding of the Spring framework. 
On the second day there was a short Spring Presentation by Ken Coenen. 
Ken explained how all the Spring magic works behind the scenes 
and talked about the common components of the full Spring framework.


### Unit Testing
<img class="image right medium" alt="JUnit logo" src="/img/2020-03-31-Young-Professional-2020-Light/junit.png">

We also had a course about testing. We had an interactive hands-on session about multiple subjects like Test Driven Development, 
goals of testing, what to test, fixtures, mocks and assertions.

### Databases
<img class="image left medium" alt="PostgreSql logo" src="/img/2020-03-31-Young-Professional-2020-Light/postgre-sql.png">

Databases are essential to the development of applications, you will almost always need some form of data storage. 
So we followed a session with Tom Van den Bulck who showed us all kinds of databases. 
First we saw a traditional relational database, in this case PostgreSQL, 
a database which is widely known and used in many different projects around the world. 

<img class="image right medium" alt="MongoDB logo" src="/img/2020-03-31-Young-Professional-2020-Light/mongodb.png">

Then we stepped away from relational databases to look at other kinds. 
More specifically MongoDB which is a non relational database, otherwise known as a NoSQL database. 
In MongoDB's case it's a document store. 
Here you don't have a fixed schema, 
instead you upload JSON documents which you can then easily query using an SQL style query syntax. 
Apart from MongoDB we also learned about Cassandra, which is a NoSQL column store, and Redis, which is a key value store. 
Last but not least we studied a graph database, namely Neo4J. 

# Front end

### HTML, CSS, Javascript
<img class="image left medium" alt="HtmlCssJs logo" src="/img/2020-03-31-Young-Professional-2020-Light/html-css-js.png">

Since the Young Professional programme teaches a wide array of technologies we have seen quite a few front end technologies.
Starting off with the basics of almost every front end technology, HTML5, CSS and JavaScript. 
In the first part of this session we took a dive into the basics of HTML and CSS, 
and after this we learned about the more recent features of HTML5 and CSS3. 
The remainder of the session was mainly about JavaScript. 
Throughout the session we had some exercises to have a bit of a hands-on approach.
    


### Typescript
<img class="image right medium" alt="Typescript logo" src="/img/2020-03-31-Young-Professional-2020-Light/typescript.png">

Building on the basics we learned prior, we had a session about TypeScript, 
a derivative of JavaScript that is becoming more and more popular amongst most front end frameworks 
because of its similarity to JavaScript but also having types allowing stricter rules to be enforced 
and less random unexplainable errors. 
Similarly to the previous session we got an explanation on the basics of TypeScript which was then used in some exercises.


### Angular
<img class="image left medium" alt="Angular logo" src="/img/2020-03-31-Young-Professional-2020-Light/angular.png">

Eventually we reached the end of our front end training with a 2-day Angular course. 
Everything we learnt the previous days was now being poured into a framework. 
In this course we, again, saw the basics of this massive TypeScript framework. 
We saw everything from dependency injection to property binding. 
Angular is a framework built by Google so there are lots of features, 
because of this we didn't have enough time in those 2 days to really explore Angular in-depth. 
This is the preferred front end technology in JWorks. 
We were also going to use it in the dev case, so we would have enough time to understand it on a deeper level.


# Cloud

### Docker
<img class="image right medium" alt="Docker logo" src="/img/2020-03-31-Young-Professional-2020-Light/docker.png">

To start off our cloud education we had a session about Docker, which is essential to many cloud technologies. 
Tom Verelst gave an interesting hand-on session where he first explained the concepts of Docker, 
then we started writing our own yaml deployment files to set up our first full stack application.

### Kubernetes
<img class="image left medium" alt="Kubernetes logo" src="/img/2020-03-31-Young-Professional-2020-Light/kubernetes.png">

Kubernetes is an open source container orchestration framework, which is commonly used to deploy applications. 
Pieter Vincken taught us the basics of Kubernetes. 
We started with a presentation about the core concepts like pods, secrets and more. 
Then we learned how to deploy and manage our Docker containers using Kubernetes. 
During this session we got the hang of how you could manage your clusters by using various techniques provided by Kubernetes 
like auto scaling, load balancing,... 
It was really insightful to see how easy it is to deploy and manage your applications on a Kubernetes cluster. 

### Security Principles
<img class="image right medium" alt="Security logo" src="/img/2020-03-31-Young-Professional-2020-Light/security.jpeg">
In this day and age security is a hot topic. 
During this session we went over the basics on how to protect your application. 
From validating user input to database security, but also how to protect the users' data.

# Clean Code
<img class="image left medium" style="margin: 1.5em;" alt="CleanCode logo" src="/img/2020-03-31-Young-Professional-2020-Light/clean-code.png">

Today, one of the most important skills a developer has is Clean Code. 
To explore this complex topic, we read the book 'Clean Code' by Robert C. Martin, 
which is one of the must reads for every programmer.
To be able to write clean code, an understanding of what bad code is is needed. 
This is also explained in the first chapter of the book.
Some examples of topics in the book we still use everyday are: 
- Avoiding comments but using descriptive names
- Functions should be small and do one thing
- Use one word per concept
- ...

# Dev case
### Introduction
For our dev case, our task was to make a fully functional web application for [MFC Combo](https://www.mfccombo.be){:target="blank" rel="noopener noreferrer"}. 
MFC Combo is an organization in youth care who guide families and children with a difficult situation at home. 
They use the "Combobox" in their meetings with the families. 
This is used to make communication easier and more fun.
Right now, they have physical stickers and papers to let the child express their feelings, 
but they want it to become digital so that it's easier to follow up a child.

## Technology & Methodologies
We worked Agile in two-weekly sprints with all the Scrum Ceremonies. 
Azure DevOps made this process easy and made sure our code was always clean and working as expected using CI/CD. 
For the front end, we used the Angular Framework to develop the application, combined with Jasmine and Karma for testing. Authentication was done using AWS Amplify, which is a development platform. 
This allowed us to quickly set up the authentication and authorization of our app. 
Sentry.io was used for front end logging and monitoring after deployment. 
This way, we had full control over our code, from development to deployment and even after deployment.
For the back end, we used Java Spring Boot 2.3.1. 
Our Database was a NoSQL DynamoDB, for user management we used Cognito and finally for our file storage we used an S3 bucket. All of these services were set up in AWS. 
This means we used the AWS Java SDK to manipulate these services in an easy and structured way.

### Result
<img class="image" alt="Drag & drop gif"  style="max-width: 50%; padding-left medium: 4px" src="/img/2020-03-31-Young-Professional-2020-Light/board.gif">

After 10 sprints we created an online platform for Combobox. 
This platform would assist them in their day-to-day operations. 
The application included various features like: drag & drop capabilities, user management, file management, 
sticker management, overview of current cases, authorization & authentication. 
One of the most challenging parts of the project was the implementation of the Drag & Drop feature, 
for which we created a new directive. 
The result can be seen in the following screenshots:

<img class="image" alt="Login Page" style="max-width: 100%;" src="/img/2020-03-31-Young-Professional-2020-Light/login.jpg">

<img class="image" alt="Upload Page"  style="max-width: 100%;" src="/img/2020-03-31-Young-Professional-2020-Light/upload.jpg">

<img class="image" alt="Fox Icon" src="/img/2020-03-31-Young-Professional-2020-Light/icons8-fox-48.png"
title="Fox icon by Icons8, those who know, will know."
style="margin: auto;">


