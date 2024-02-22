---
layout: post
authors: [oumaima-zerouali, viktor_van_steenweghen]
title: 'The Imperfect Yet Crucial Role of Performance Testing'
image: /img/2024-02-15-performance-testing/banner.png
tags: [ Testing, Development, performance testing]
category: Testing
comments: true
---
> Ah, the inner machinations of performance testing are an enigma.

{:.no_toc}
- TOC
{:toc}

## Introduction
Attending FOSDEM 2024 was an eye-opening experience, especially the lecture on performance testing, which underscored its vital role in software development.

It's incredible how something seemingly technical can have such a profound impact on the reliability, speed, and scalability of applications. In this article, we'll explore the critical role of performance testing in software development. We'll discuss its importance in identifying bottlenecks, enhancing user experience, and why it's essential for businesses. Additionally, we'll address the challenges of performance testing and introduce Gatling as a tool for database performance monitoring. Let's dive in!

## Why Performance Testing Matters
Performance testing serves as a crucial element in guaranteeing that applications not only meet but surpass the expectations of both users and businesses. It transcends basic functionality testing, delving deeply into the nuances of how an application operates under diverse conditions and workloads.

### Identifying and Enhancing Performance Bottlenecks to Improve User Experience
One of the primary objectives of performance testing is to identify bottlenecks within an application. These bottlenecks could manifest as slow response times, excessive resource consumption, or scalability limitations. By pinpointing these bottlenecks early in the development cycle, developers can take proactive measures to address them, thereby optimizing the overall performance of the application.

In today's digital landscape, user experience reigns supreme. Poor performance can lead to frustration, dissatisfaction, and ultimately, abandonment of the application. Performance testing plays a crucial role in ensuring that the application delivers a seamless and responsive user experience, regardless of the user's device, location, or network conditions. By optimizing performance, businesses can enhance user satisfaction, loyalty, and retention.

### Compelling Reasons to Prioritize Performance Testing
Here are several compelling reasons for prioritizing performance testing:
- **Performance Gain:** Optimizing product performance directly translates to tangible benefits for businesses, including increased customer satisfaction, higher conversion rates, and improved bottom-line revenue.
- **Deeper Understanding:** Performance testing provides developers with invaluable insights into the underlying intricacies of an application's architecture, codebase, and infrastructure. By understanding how the application performs under different conditions, developers can make informed decisions to optimize its performance.
- **Baseline Figures:** Obtaining baseline performance metrics serves as a foundational reference point for future iterations of the application. These metrics provide a benchmark against which future performance improvements can be measured, enabling continuous enhancement and refinement of the application.

In essence, performance testing is not just a technical necessity but a strategic imperative for businesses looking to deliver high-quality, high-performing applications that delight users and drive success in today's hyper-competitive digital landscape.

## Challenges and the Imperfect Nature of Performance Testing
Acknowledging the imperfections inherent in performance testing is crucial for understanding the challenges faced in this domain. Despite these challenges, it's imperative to recognize the importance of imperfect performance testing and how it continues to provide value in software development:

### Early Detection and Continuous Improvement
Even in its imperfect state, performance testing serves as a vital tool for early issue detection and continuous improvement. By uncovering critical issues and bottlenecks early in the development cycle, developers can take corrective action before they escalate into more significant problems. This iterative refinement process fosters a culture of continuous improvement, leading to incremental performance gains over time.

### Real-World Insights and Complexity
Imperfect performance testing provides invaluable insights into how applications behave under real-world conditions, including stress, resource limitations, and unexpected usage patterns. However, testing such complex systems requires a deep understanding of their inner workings, posing a significant challenge. Additionally, the dynamic nature of software environments introduces further complexity, making it impossible to replicate every possible scenario in controlled testing environments.

### Resource Constraints and Evolving Requirements
Performance testing often demands substantial resources, including hardware, software, and human expertise. Not all organizations have access to such resources, making comprehensive testing challenging. Moreover, keeping pace with evolving technology landscapes and ever-changing requirements adds another layer of complexity. However, despite these challenges, performance testing remains indispensable for ensuring application reliability, scalability, and efficiency.

Despite these challenges and recognizing the imperfect nature of performance testing, its value remains undeniable. It acts as a proactive safeguard, enabling developers to identify and address issues early in the development cycle, paving the way for continuous improvement and optimization. Even in its imperfect state, performance testing provides invaluable real-world insights into application behavior across diverse conditions, empowering developers to make informed decisions and prioritize enhancements that resonate with end users.

##   Essential Components for Effective Performance Testing
When undertaking performance testing, it's vital to consider various components to ensure a thorough evaluation:

### Load Testing & Stress Testing
Load testing involves simulating real-world loads on web services to assess their performance under normal conditions, while stress testing pushes the system to its limits to identify its breaking point. Tools like Gatling offer scripting capabilities to define complex load scenarios and analyze performance under varying loads. Load testing helps gauge how the application handles typical user loads, while stress testing identifies weaknesses and potential failure points under extreme conditions.

### Endurance Testing
Endurance testing evaluates how well the application performs over prolonged periods, ensuring stability without memory leaks or performance degradation. Continuous load tests running for several hours or days monitor metrics like memory usage, CPU utilization, and other system parameters. Endurance testing is crucial for identifying any degradation in performance over time, ensuring that the application remains stable and reliable during extended usage.

### Scalability Testing
Scalability testing assesses how well the application can handle increased load by measuring metrics like throughput, response time, and resource utilization. Tools like Gatling can simulate gradual increases in the number of users or transactions to observe how the system scales horizontally or vertically. Scalability testing helps identify performance bottlenecks and capacity limits before deploying the application to production, ensuring that it can accommodate growth without sacrificing performance.

### API Performance
APIs play a critical role in modern web applications, facilitating communication between different components. API performance testing, conducted using tools like Apache JMeter, involves sending HTTP requests and measuring response times to ensure that APIs meet performance requirements. Simulating various API calls with different payloads helps analyze how backend services respond under different load conditions. API performance testing ensures that APIs can handle expected traffic volumes without degradation, maintaining optimal performance for end users.

### Automation & Integration
With the adoption of DevOps practices, automation and integration are essential for streamlining the performance testing process. Tools like Apache Maven enable the automation of performance tests as part of the continuous integration pipeline. Integrating performance testing tools with build servers like Jenkins or CI/CD platforms like GitHub ensures that performance tests are run automatically on code changes. Additionally, open-source automation frameworks like Selenium can be used to automate web application tests, complementing performance testing efforts and ensuring comprehensive test coverage across the application stack. Automation and integration help improve efficiency, consistency, and reliability in performance testing processes, enabling faster feedback and quicker resolution of performance issues.

## Performance testing with Gatling
Gatling is a powerful open-source tool designed for performance testing, renowned for its efficiency and flexibility. It allows developers to simulate real-world scenarios and assess the performance of their applications under various load conditions. Gatling uses a scenario-based approach, where users define test scenarios using a simple yet expressive DSL (Domain-Specific Language). These scenarios can simulate user interactions, such as browsing web pages, submitting forms, or making API calls.

## Gatling
During our devcase, we came into contact with Gatling for the first time. The task was to build an application that could retrieve data from a smart electricity meter and translate it into something understandable for people.

So, data had to be stored and processed. For this, we used a lambda to convert the raw data and store it in a Timestream database.

To avoid the application crashing when more than 5 users simultaneously send the data from their meter, it was important to perform performance testing. It was important to know approximately how many simultaneous users the system could handle before it failed. For this, we used Gatling.

## Structure of Gatling Code
The Gatling code is structured as follows:

The httpProtocolBuilder
The httpProtocolBuilder creates an HTTPProtocolBuilder object, which is used to define the configuration of the HTTP protocol.

![httpProtocol.png](C:\Users\ViVS\Documents\JWorks-blog\img\2024-02-23-performance-testing\httpProtocol.png)

The ScenarioBuilder
The scenario builder defines a scenario that describes interactions with the web application. A scenario can consist of one or more HTTP requests you want to test, as well as the order in which they should be executed.

![scenario.png](C:\Users\ViVS\Documents\JWorks-blog\img\2024-02-23-performance-testing\scenario.png)

The Setup
This is a method in Gatling that allows you to set up the test scenarios and configure the simulation before it is executed. It accepts one or more scenarios and executes them. This consists of 2 parts:

scn.injectOpen(...): This part of the code configures the injection of user behavior into the scenario scn. In this case, user behavior is injected according to a certain pattern.

rampUsers(100).during(100): This specifies the injection pattern for users. It means that the number of users will gradually increase from 0 to 100 over a period of 100 seconds. In other words, every second, the number of concurrent users will increase by an average of 1 until reaching 100.

![setup.png](C:\Users\ViVS\Documents\JWorks-blog\img\2024-02-23-performance-testing\setup.png)

## Results
After Gatling has run its tests, a comprehensive report is generated. From this, you can observe several interesting things. Here are a few examples:

Response Times: The report will contain data on the average, minimum, maximum, and 95th percentile response times. These measurements show how quickly the application responds to different types of requests. A lower response time is generally desirable as it indicates a faster application response.

![response.png](C:\Users\ViVS\Documents\JWorks-blog\img\2024-02-23-performance-testing\response.png)

Errors: The report may contain information about any errors that occurred during the test, such as server errors, timeouts, or incorrect responses. This information can indicate where the application is lacking and which parts of the application may need improvement.

![response.png](![response.png](C:\Users\ViVS\Documents\JWorks-blog\img\2024-02-23-performance-testing\response.png))

From these results, we can deduce that the lambda and the database are capable of handling the requests from 100 concurrent users, but as seen in the results, it takes an average of 1200 ms to handle such a request. This is still relatively long and could be further optimized.

## Conclusion
In the realm of software development, performance testing serves as the backbone, ensuring applications stand strong in terms of reliability, scalability, and efficiency. While the pursuit of perfection may seem daunting, the quirks and challenges inherent in the process remind us of the complex nature of modern software and the evolving expectations of users.
This analysis highlights the critical importance of performance testing. It was observed that while the application could handle the requests, it still took a long time to process them. This underscores the significance of optimizing performance. Addressing these identified issues and implementing necessary improvements can enhance application efficiency, scalability, and security, ultimately delivering a superior user experience.
The key takeaway from the FOSDEM 2024 lecture is crystal clear: although performance testing isn't flawless, its value is immeasurable. It acts as a safety net, capturing issues early in the development cycle. By embracing these imperfections, developers pave the path for continuous improvement, making their applications more resilient and effective in the long run.
