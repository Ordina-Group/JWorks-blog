---
layout: post
authors: [kevin_van_houtte]
title: 'Spring I/O 16: Test-driven documentation with Spring REST Docs'
image: /img/springio.jpg
tags: [Spring IO,Spring,Conference]
category: conference
comments: true
---

## Spring IO 2016
The main focus this year was definitely about cloud, reactive and microservices.
But it is important not to forget other topics, like documentation! 
Keep calm, you don't have to do it manually! 
Spring made it easy for us with Spring REST Docs! 
This year at Spring IO, Andy Wilkinson himself talked about why, how and when Spring REST Docs are being used. 
Last but not least, he talked about the new features that came out in version 1.1.
Since I implemented Spring REST Docs in a project, I'll use examples from my experiences.


<img class="p-image float-image" width="200" alt="Andy Wilkinson" src="/img/rest-docs/andywilkinson.jpg">

### Andy Wilkinson

Andy is a Spring Boot, REST docs committer and Spring IO platform lead at Pivotal. 
You can find him on Twitter using the handle [@ankinson](https://twitter.com/ankinson).

<blockquote class="clear"><p>
Writing documentation is critical in the world of development. 
It is used to make an accurate and straight declaration and intent of what the service has to offer. 
Frontend developers will be able to know which endpoints they have to call and receive the right data. 
Now, we all know it's tedious for developers to write documentation...
It's your lucky day! Spring REST Docs will make your life easier.
While you are writing tests, Spring will generate a fully HTML api guide for you and your team. 
This blog post will take you through the best practices, how to and new features in 1.1.
</p></blockquote>

**Why Test driven approach**

* It’s an accurate definition of your application (no side effects)
* It describes the specific HTTP request and response
* It’s straight forward without repetition
* It’s easier to write (no annotations like Swagger)

### Markup languages

#### Asciidoctor
Asciidoctor is a markup language that processes plain text and produces HTML, completely styled to suit your needs.
If you are interested in writing in Asciidoctor be sure to check out the [manual](http://asciidoctor.org/docs/user-manual/#introduction-to-asciidoctor).

#### Markdown (New in 1.1)
With the newest version of REST Docs, the developer now has more options in terms of markup languages.
The Markdown support is not as feature-rich as Asciidoctor, but Markdown can work very well when combined with existing documentation toolchains such as [Slate](https://github.com/tripit/slate).
Here is a good [sample](https://github.com/spring-projects/spring-restdocs/tree/master/samples/rest-notes-slate) working with slate.

#### Andy's pick
Asciidoctor!
Since Asciidoctor boasts more features than Markdown, it gives Asciidoctor the edge.

### Test Tools
When we want to use Spring REST Docs, we'll have to use one of the test tools. 
Here are the different tools of choice. To use these tools we'll have to initialise which document, `Mockmvc` and `ObjectWriter` we'll be using. 

#### MockMvc
A lightweight server-less documentation generation by the Spring Framework that has been the default use in Spring REST Docs.


{% highlight java %}
private MockMvc mockMvc;

@Autowired
private WebApplicationContext context;

 @Before
    public void setup() throws Exception {
        this.document = document("{method-name}");
        mockMvc = MockMvcBuilders.webAppContextSetup(wac)
                .apply(documentationConfiguration(this.restDocumentation).uris().withScheme("https")).alwaysDo(this.document)
                .addFilter(new JwtFilter(),"/*")
                .build();
        objectWriter = objectMapper.writer();

        authToken = TestUtil.getAuthToken();
        TestUtil.setAuthorities();
    }

{% endhighlight %}



#### RestAssured (New 1.1)
As an alternative, you can use RestAssured to test and document your RESTful services. 
Available in V1.1, RestAssured will be more expandable than MockMvc.

{% highlight java %}
private RequestSpecification spec;

@Before
public void setUp() {
    this.spec = new RequestSpecBuilder().addFilter(
            documentationConfiguration(this.restDocumentation)) 
            .build();
}
{% endhighlight %}



#### Andy's pick
This time he didn't favor one but he mentioned that RestAssured gives you more functionality and extends your possibilities with HTTP.


### Snip, snip, snippets everywhere!

#### Default Snippet
Snippets are generated by the documented test method.
Once you run the test method, you can add these snippets in your Markdown/Asciidoctor file. 
Be aware, these type of snippet will fail if you don't have the correct response/request syntax. 

{% highlight java %}
this.document.snippets(
                links(
                        halLinks(), linkWithRel("self").description("The employee's resource"),
                        linkWithRel("employee").optional().description("The employee's projection")),
                        responseFields(
                                fieldWithPath("username").description("The employee unique database identifier"),
                                fieldWithPath("firstName").description("The employee's first name"),
                                fieldWithPath("lastName").description("The employee's last name"),
                                fieldWithPath("linkedin").description("The employee's linkedin"),
                                fieldWithPath("unit").description("The employee's unit").type(Unit.class),
                                fieldWithPath("_links").description("links to other resources")
                        ));
 mockMvc.perform(
                get("/employees/1").accept(MediaType.APPLICATION_JSON));

{% endhighlight %}


#### Relaxed Snippet (New in 1.1)
In contrast to default snippets, relaxed snippets don't complain when something was neglected in the document.
This is an advantage when you only need to focus on a certain scenario or specific part of the response/request.

#### Reusable Snippet (New in 1.1)
With the newly introduced reusable snippet, you can define a snippet at the beginning of your test class and reuse it every time you need it. 
When added to your test method, you can extend it with extra variables. 


{% highlight java %}

// First we define a snippet for reuse
protected final LinksSnippet pagingLinks = links(
        linkWithRel("first").optional().description("The first page of results"),
        linkWithRel("last").optional().description("The last page of results"),
        linkWithRel("next").optional().description("The next page of results"),
        linkWithRel("prev").optional().description("The previous page of results"));

// Then you perform the mockMvc and add the snippet to the document.
// As you can see, it is expendable.
this.mockMvc.perform(get("/").accept(MediaType.APPLICATION_JSON))
    .andExpect(status().isOk())
    .andDo(document("example", this.pagingLinks.and( 
            linkWithRel("alpha").description("Link to the alpha resource"),
            linkWithRel("bravo").description("Link to the bravo resource"))));
{% endhighlight %}


## Type of Snippets:
A snippet can be one of the following:

### Hypermedia links
When documenting your hypermedia application, you'll have to define your links and where they go to. 
If you have dynamic links that can disappear at one time, you can use relaxed snippets or optional so it won't complain.

{% highlight java %}
 this.document.snippets(
                links(
                        halLinks(), linkWithRel("self").description("The employee's resource"),
                        linkWithRel("employee").optional().description("The employee's projection")),
                responseFields(
                        fieldWithPath("username").description("The employee unique database identifier").type(String.class),
                        fieldWithPath("_links").description("links to other resources")
                ));
{% endhighlight %}


### Request fields
This defines the fields you request from the client.
Normally Spring REST Docs will complain when you neglect a field but with v1.1 we now have support for Relaxed Snippets.
Because I use constraints, I made my own method `withPath, this will add an extra column constraint to the documentation.
{% highlight java %} 
 private static class ConstrainedFields {
         private final ConstraintDescriptions constraintDescriptions;
         ConstrainedFields(Class<?> input) {
             this.constraintDescriptions = new ConstraintDescriptions(input);
         }
         private FieldDescriptor withPath(String path) {
             return fieldWithPath(path).attributes(key("constraints").value(StringUtils
                     .collectionToDelimitedString(this.constraintDescriptions
                             .descriptionsForProperty(path), ". ")));
         }
     }

 @Test
 public void postEmployee() throws Exception{
         Employee employee = employeeRepository.findByUsernameIgnoreCase("Nivek");
         employee.setId(null);
         employee.setUsername("Keloggs");
         String string = objectWriter.writeValueAsString(employee);
 
         ConstrainedFields fields = new ConstrainedFields(Employee.class);
 
         this.document.snippets(
                 requestFields(
                         fields.withPath("username").description("The employee unique database identifier"),
                         fields.withPath("firstName").description("The employee's first name"),
                         fields.withPath("lastName").description("The employee's last name"),
                         ));
 
         mockMvc.perform(post("/employees").content(string).contentType(MediaTypes.HAL_JSON).header("Authorization", authToken)).andExpect(status().isCreated()).andReturn().getResponse().getHeader("Location");
     }
                        
      
{% endhighlight %}

### Response fields
This defines the result after consultation of a resource.
{% highlight java %}
  this.document.snippets(
              responseFields(
                       fieldWithPath("username").description("The employee unique database identifier"),
                       fieldWithPath("firstName").description("The employee's first name"),
                       fieldWithPath("lastName").description("The employee's last name"),
                           ));
{% endhighlight %}


### Request/response headers
Defines your request/response headers in your API. 
This is useful when there are extra headers to set. 
When the request has to involve an authorization header for security reasons, you can add this header to your document.

{% highlight java %}
mockMvc.perform(
                get("/employees/1").accept(MediaType.APPLICATION_JSON)
                .header("Authorization", authToken)
                .andDo(document("headers",
                				requestHeaders( 
                						headerWithName("Authorization").description(
                								"Basic auth credentials")), 
                				responseHeaders( 
                						headerWithName("X-RateLimit-Limit").description(
                								"The total number of requests permitted per period"),
                						headerWithName("X-RateLimit-Remaining").description(
                								"Remaining requests permitted in current period"),
                						headerWithName("X-RateLimit-Reset").description(
                								"Time at which the rate limit period will reset")))));
{% endhighlight %}

### Request parameters
The parameters passed by in the uri as a query string are documented with the requestParameters.
{% highlight java %}

this.mockMvc.perform(get("/users?page=2&per_page=100")) 
	.andExpect(status().isOk())
	.andDo(document("users", requestParameters( 
			parameterWithName("page").description("The page to retrieve"), 
			parameterWithName("per_page").description("Entries per page") 
	)));
	
	
{% endhighlight %}


### Request parts (new in 1.1)
The parts of a multipart request can be documenting using `requestParts`

Example

{% highlight java %}
RestAssured.given(this.spec)
	.filter(document("users", requestParts( 
			partWithName("file").description("The file to upload")))) 
	.multiPart("file", "example") 
	.when().post("/upload") 
	.then().statusCode(is(200));
{% endhighlight %}


## What makes good documentation?

### Andy's pick
He told us that the [GitHub API](https://developer.github.com/v3/) is one of the most complete and correct documentation there is. 
So if you want some guidelines, inspire yourself with this API.

### Structure and accuracy
When documenting your application, your accuracy has to be 100% correct and understandable. 
The structure of your API is the representation of your application, so it better be good.

### Cross-cutting concerns
Andy put forward to document cross-cutting concerns on a general documentation level, avoiding repeating yourself in every single documented API call.
Concerns who made it to the top are:

* Rate limiting 
* Authentication and authorisation

#### And HTTP verbs/codes (PATCH VS PUT)
To be RESTfull, you'll have to follow the guidelines in having a correct API design. 
This [picture](https://upload.wikimedia.org/wikipedia/commons/8/88/Http-headers-status.png) shows you how and when to use the correct verbs and HTTP codes




### 3 main questions if you are working with resources
   * What do they represent?
   * What kind of input do they accept?
   * What output do they produce?

Last but not least: do not document uri’s!

## Questions

### Will constraints be officially added in future releases?
The constraints snippets won't be added in the future.
This is because Andy wants to give the developers the choice of what they want to implement.


## Conclusion
Since Spring REST Docs is so effective in bringing documentation to the fun part of development I highly recommend to use this in your future Spring applications. 
Not only you will be smiling when the API guide is being generated but the Frontend developers will get a more understandable view of the backend.


## Sources
 * [@ankinson](https://twitter.com/ankinson)
 * [Spring REST Docs](http://docs.spring.io/spring-restdocs/docs/1.0.x/reference/html5/)
 * [GitHub API](https://developer.github.com/v3/)
 * [Verbs & HTTP codes](https://upload.wikimedia.org/wikipedia/commons/8/88/Http-headers-status.png)
 * [Asciidoctor manual](http://asciidoctor.org/docs/user-manual/#introduction-to-asciidoctor)
 * [Slate example](https://github.com/spring-projects/spring-restdocs/tree/master/samples/rest-notes-slate)
