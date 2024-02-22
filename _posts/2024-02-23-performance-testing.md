---
layout: post
authors: [oumaima-zerouali, viktor_van_steenweghen]
title: 'The Imperfect Yet Crucial Role of Performance Testing'
image: /img/2024-02-23-performance-testing/banner.png
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

### Gatling
During our devcase, we came into contact with Gatling for the first time. The task was to build an application that could retrieve data from a smart electricity meter and translate it into something understandable for people. So, data had to be stored and processed. For this, we used a lambda to convert the raw data and store it in a Timestream database.

To avoid the application crashing when more than 5 users simultaneously send the data from their meter, it was important to perform performance testing. It was important to know approximately how many simultaneous users the system could handle before it failed. For this, we used Gatling.

### Structure of Gatling Code
The Gatling code is structured as follows:

#### The httpProtocolBuilder
The httpProtocolBuilder is a fundamental component in Gatling scripts, responsible for defining the configuration of the HTTP protocol used in our performance tests. It allows us to set various parameters and characteristics related to HTTP communication, ensuring accurate simulation of real-world scenarios.

The configuration options provided by the `HTTPProtocolBuilder` enable precise control over aspects such as:
- Request Headers: Specification of headers such as User-Agent, Content-Type, and Accept headers, which mimic the   behavior of actual web browsers or API clients.
- Request Timeouts: Setting timeouts for establishing connections, receiving responses, or overall request durations, ensuring realistic behavior under varying network conditions.
- Proxy Configuration: Configuring proxy settings for simulating requests through intermediary servers, relevant for testing applications deployed behind proxies.
- SSL/TLS Settings: Configuring SSL/TLS parameters such as cipher suites, SSL protocols, and certificate validation settings to mimic secure communication.
- Response Handling: Defining how Gatling should handle responses, including following redirects, handling cookies, and managing session data.

By customizing these settings within the httpProtocolBuilder, we can create test scenarios that closely resemble the behavior of real users interacting with our application or API.

![httpProtocol.png](..%2Fimg%2F2024-02-23-performance-testing%2FhttpProtocol.png)

#### The ScenarioBuilder
In Gatling, the ScenarioBuilder plays a pivotal role in crafting realistic user interactions with the web application being tested. It serves as the blueprint for defining various user journeys or workflows, encompassing the sequence of HTTP requests to be made and the order in which they should occur.

A `ScenarioBuilder` typically includes the following key elements:
- HTTP Requests: Specification of the HTTP requests to be sent to the target application or API. These requests represent user actions such as navigating to a webpage, submitting a form, or interacting with API endpoints.
- Order of Execution: Determination of the sequence in which the HTTP requests should be executed within the scenario. This sequencing ensures that the simulated user interactions align with real-world usage patterns.
- Think Times: Introduction of delays or "think times" between requests to mimic the pauses users naturally make while interacting with the application. These pauses add realism to the simulation and help avoid overloading the server with rapid-fire requests.

The ScenarioBuilder empowers us to create diverse and intricate scenarios that mirror the complexity of user interactions in production environments. By accurately replicating user behavior, we can assess how the application performs under different usage scenarios and identify any performance bottlenecks or issues.

![scenario.png](..%2Fimg%2F2024-02-23-performance-testing%2Fscenario.png)

#### The Setup
This is a method in Gatling that allows you to set up the test scenarios and configure the simulation before it is executed. It accepts one or more scenarios and executes them. This consists of 2 parts:

**scn.injectOpen(...)**: This segment of the code is responsible for configuring the injection of user behavior into the scenario (scn). Here, we define the pattern or strategy for simulating user interactions within our test scenarios. For instance, we can specify how users are injected into the scenario over time, whether it's a gradual ramp-up, a constant load, or a spike in user activity.

**rampUsers(100).during(100)**: This part of the setup specifies the injection pattern for users. In this example, it indicates that the number of virtual users will gradually increase from 0 to 100 over a duration of 100 seconds. In simpler terms, with each passing second, Gatling will introduce an additional virtual user into the scenario until reaching a total of 100 concurrent users. This gradual ramp-up helps simulate realistic user load patterns and allows us to observe how the system performs under increasing levels of stress.

![setup.png](..%2Fimg%2F2024-02-23-performance-testing%2Fsetup.png)

#### Results
Following the completion of Gatling tests, a comprehensive report is generated, providing valuable insights into the performance of the tested application. Here are some key observations typically found in the report:

**Response Times**: The report includes data on various metrics related to response times, such as average, minimum, maximum, and 95th percentile response times. These metrics indicate how quickly the application responds to different types of requests. Lower response times are generally preferable as they signify faster application responsiveness.
![response.png](..%2Fimg%2F2024-02-23-performance-testing%2Fresponse.png)

**Errors**: Information regarding any errors encountered during the test is documented in the report. These errors may include server errors, timeouts, or incorrect responses. Identifying and addressing these errors is crucial for improving application reliability and user experience.
![fouten.png](..%2Fimg%2F2024-02-23-performance-testing%2Ffouten.png)

From the results obtained, we can infer that the tested lambda function and database are capable of handling requests from 100 concurrent users. However, it is noted that the average response time for such requests is approximately 1200 ms. While functional, this response time may be considered relatively long and suggests room for optimization to enhance overall system performance.
## Conclusion
In the realm of software development, performance testing serves as the backbone, ensuring applications stand strong in terms of reliability, scalability, and efficiency. While the pursuit of perfection may seem daunting, the quirks and challenges inherent in the process remind us of the complex nature of modern software and the evolving expectations of users.
This analysis highlights the critical importance of performance testing. It was observed that while the application could handle the requests, it still took a long time to process them. This underscores the significance of optimizing performance. Addressing these identified issues and implementing necessary improvements can enhance application efficiency, scalability, and security, ultimately delivering a superior user experience.
The key takeaway from the FOSDEM 2024 lecture is crystal clear: although performance testing isn't flawless, its value is immeasurable. It acts as a safety net, capturing issues early in the development cycle. By embracing these imperfections, developers pave the path for continuous improvement, making their applications more resilient and effective in the long run.
