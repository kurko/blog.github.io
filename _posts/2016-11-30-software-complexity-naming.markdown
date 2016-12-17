---

layout: post
title:  "Software Complexity: Naming"
date:   2016-11-30 20:00:00 -0200
categories: software-complexity
excerpt: ""

---
Resource:

* http://softwareengineering.stackexchange.com/questions/119345/meaningful-concise-method-naming-guidelines
* http://pt.slideshare.net/pirhilton/how-to-name-things-the-hardest-problem-in-programming
* http://www.randomprogramming.com/2014/09/quote-of-the-week-hard-things/
* How to name things, by G. Orwell ‘What is above all needed is to   let the meaning choose the word,   and not the other way around. … the worst thing one can do with words is surrender to them.
 * "Reality exists in the human mind and nowhere else." George Orwell
 * Cartoon about ResponseBuilder or StringBuilder or TransactionBuilder
 * Helper
 
# Software Complexity: Naming

> There are only two hard things in Computer Science: cache invalidation and naming things.
>
> Phil Karlton

Code is how we communicate with the machine, but perhaps most importantly, how we convey ideas and processes to our human peers. One has an abstract idea and so writes it down, concretizing it, so that a fellow reader can reason about it. The cognitive impact will be determined by how that expression is laid out. To me, that puts software in the social science bucket.

Names, core of expression, affect how fast we will get to our success.

* In software, why is it so hard to name things?
* How can bad naming affect success?
* What framework can we use to find names more easily?
* how much
* how many
* Review text: same domain in which dimension? Location, functionality, purpose?

**"Opposite" and "other way around" are the same way of saying the same thing. One is simpler though.**

## Naming Components

To illustrate our first concept, let's play a game. It's called _"What room are we in?"_. I will give you a picture and you have to say what room this is.

**Question 1/3**

<br />
<br />

![A couch, what room does it belong to?](/images/software-complexity-naming/couch-in-what-room.png)

<br />
<br />

Judging by this furniture, this is certainly the **living room**. Based on a component, we know the name of the room we're in. That was easy. One more.

**Question 2/3**

<br />
<br />

![A toilet, what room does it belong to?](/images/software-complexity-naming/toilet-in-what-room.png)

<br />
<br />

Based on this object, we can say fairly sure that this is the **restroom**.

See a pattern here? The name of the room is a **label** that defines what is inside. With that label we don't need to look inside the container to know what elements are there. That enables us to establish our first corollary:

**Corollary 1: container name is a function of its elements.**

Note it is basically Duck Typing. Does it have a bed? Then it's a bedroom.

Now, the opposite is also true: based on the container name we can infer its components. If we were talking about a _bedroom_ it would very likely that it had a bed. That enables us to define our second corollary:

**Corollary 2: we can infer components based on the container name.**

Now that we have some rules, let's try to apply them to this next room.

**Question 3/3**

<br />
<br />

![What room is this that has a toilet and a bed?](/images/software-complexity-naming/toilet-bed.png)

<br />
<br />

Ok, a bed and a toilet in the **same room**? That makes its definition pretty much blurry, foggy and if I had to use corollaries 1 and 2 to name this room, I would call it the _Monster Room_.

The problem here lies not in the amount of objects in the same room, but that completely unrelated things are being treated as if they had the same function. At our home, we put together things that have the same concern and that makes organizing easier, whereas by messing with these responsibilities we cannot be sure what the constructors wanted or how these objects are meant to be used.

**Corollary 3: the clarity with which a container is defined is proportional to how closely related its components are.**

This is hard, so let's use a picture:

![Clarity vs relation](/images/software-complexity-naming/clarity-vs-relation.png)

When components are related, it's easier to find a good name. When things are unrelated, it becomes increasingly difficult.

In software, the same also applies. We have components, classes, functions, services, application, little monsters. As Robert Delaunay said, _"Our understanding is correlative to our perception."_ Does our code allow readers to perceive business needs and requirements in the simplest way possible?

Example: HTTP is a domain and it has requests and responses. If we were to put a component called _Car_ within it, we wouldn't be able to call it HTTP anymore. In this case, it becomes something confusing.

```java
public interface MyClass {
	
	/* methods for a car */
	public void run();
	public void break();

	/* methods for an HTTP client */
	public Response makeRequest(String param);	
	public Response makeRequest(String param);	
}
```


### In Practice: Real Life Examples

Let's look at a few real life examples. First one, the [I18n](https://github.com/svenfuchs/i18n/blob/master/lib/i18n.rb) Ruby gem (only class and method names provided for brevity):

```ruby
class Base
  def config
  def translate
  def locale_available?(locale)
  def transliterate
end
```

Classes named _Base_ were a convention a long ago in C# to designate inheritance when lacking a better name. For example, the parent class of _Automobile_ and _Bicycle_ would be _Base_ instead of _Vehicle_. In spite of Microsoft's recommendations to avoid that name (Cwalina, 2009), it infected the Ruby world, most notable via _ActiveRecord_. To this day we still see Base as a class name for something that developers cannot find a name for.

Variations of _Base_ include _Common_, _Utils_ and _Helpers_. The [JSON](https://github.com/flori/json/blob/65297fbae1e92e26fdde886fe156bac322977db2/lib/json/common.rb) Ruby gem _Common_ class has the methods _parse_, _generate_, _load_ and _jj_, for instance. We will look at these in more detail later.

When we talk about how names can guide our design, Discourse has a few examples, one of which interests us.

```ruby
class PostAlerter
  def notify_post_users
  def notify_group_summary
  def notify_non_pm_users
  def create_notification
  def unread_posts
  def unread_count
  def group_stats
end
```

The name _PostAlerter_ suggests functionalities that _alert_ someone about a post. However, _unread_posts_, _unread_count_ and _group_stats_ clearly deal with something else, making this class name not ideal for what it does. Moving those three methods to a class called _PostsStatistics_ would make matters clearer and more predictable for newcomers.

The Spring framework has a few examples that illustrate components that do too much and, as a result, require name that resembles our _Monster Room_. Here is [one](http://docs.spring.io/spring/docs/2.5.x/javadoc-api/org/springframework/aop/config/SimpleBeanFactoryAwareAspectInstanceFactory.html) (because [this one](http://www.javafind.net/gate.jsp?q=%2Flibrary%2F36%2Fjava6_full_apidocs%2Fcom%2Fsun%2Fjava%2Fswing%2Fplaf%2Fnimbus%2FInternalFrameInternalFrameTitlePaneInternalFrameTitlePaneMaximizeButtonWindowNotFocusedState.html) would be too much):

```java
class SimpleBeanFactoryAwareAspectInstanceFactory {
  public ClassLoader getAspectClassLoader()
  public Object getAspectInstance()
  public int getOrder() 
  public void setAspectBeanName(String aspectBeanName) 
  public void setBeanFactory(BeanFactory beanFactory)
} 
```

Enough of bad naming. A good naming can be found in D3's  [arc](https://github.com/d3/d3-shape/blob/master/src/arc.js), for instance:

```javascript
export default function() {
  /* ... */
  arc.centroid     = function() { /* ... */ }
  arc.innerRadius  = function() { /* ... */ }
  arc.outerRadius  = function() { /* ... */ }
  arc.cornerRadius = function() { /* ... */ }
  arc.padRadius    = function() { /* ... */ }
  arc.startAngle   = function() { /* ... */ }
  arc.endAngle     = function() { /* ... */ }
  arc.padAngle     = function() { /* ... */ }
  return arc;
}
```

Each one of these methods make total sense: they are all named after what an arc has.

### Method One: Breaking Apart

![Divide and... name](/images/software-complexity-naming/divide-and-name.png)

<br />
This method is generally used when you already have isolated concepts and you want to find good names for their grouping. It consists of two steps:

1. identify the concepts we have
2. break them apart

In the toilet + bed scenario, we pull apart each different thing we can identify by pushing bed to the left, toilet to the right. Ok, now we have two separate things that we can finally reason about in a natural way.

When you cannot find a good name for something, you probably have more than one thing in front of you. And, as you know by now, naming multiple things is hard. When in trouble, try to identify what pieces and actions compose what you have.

For example, when you have code in front of you and you don't know how to name it, think of the parts. If we have a class without name and we figure out that it has a request, a response, headers, URLs, body, caching, timeouts. If you pull all those apart from the main class, we're left with the classes `Request`, `Response`, `Headers`, `URLs`, `ResponseBody`, `Cache`, `Timeout` and so on. If all we had was the name of these classes, we could fairly sure assume we were dealing with a web request. A good candidate for a web request tool is `HTTPClient`.

When the code is hard, don't think about the whole first. Don't. Think about the parts. 

### Method 2: Domain Terminology

* DDD book
* Ride, when we used to call trip, but clients called ride.

### Method 3: Criteria For Grouping

* https://en.wikipedia.org/wiki/Organizing_(management)
* https://www.google.com.br/imgres?imgurl=http%3A%2F%2Ffinegamedesign.com%2Fgraph%2Fmmpgamegraph.gif&imgrefurl=http%3A%2F%2Ffinegamedesign.com%2Fgraph%2F&docid=_699yRFT-TNrBM&tbnid=ipPGm0OZuji0qM%3A&vet=1&w=474&h=177&client=safari&bih=716&biw=1276&q=conceptual%20graph%20knowledge%20relationship%20degree&ved=0ahUKEwjuzNDQj-rQAhWFC5AKHSMyBAsQMwgmKAowCg&iact=mrc&uact=8
* https://zipmark.slack.com/archives/D2VLR9WGP/p1481646138000002

We group things based on a variety of criterias, like Examples of areas:

* physical
* economic
* emotional
* social
* functional

Couch and TV stay in the same room, grouped together based on a functional criteria, e.g. they have the same function or purpose, to provide leisure.



* Follow the idioms of my language. Ruby likes underscores. Javascript likes camel case. Whatever language you're in is the convention to follow.

* Reveals the intent of the API. It's not "send_http_data" it's "post_twitter_status"

* Avoid leaking implementation details. Say, prefixing a variable with a type.

* Does not use more characters than necessary without breaking the previous guidelines.

* Vicious

## Context


### In practice: real life examples

* https://zipmark.slack.com/archives/engineering/p1481216279000020
* Transactions when I worked at Skyo (Cybersource etc), where I created a PaymentRequest class to hold all the info about a payment.


## Meaningless names

* https://zipmark.slack.com/archives/D2VLR9WGP/p1481646138000002
* Tasks: https://zipmark.slack.com/archives/D2P4PLKBP/p1481730816000049

Over the years, these meaningless names acquired meaning due to its usage. 

_Helper_: lumped together in an unnatural grouping to provide reusability for some miscellaneous, commonly used operation. They tend suffer from [Feature Envy](https://sourcemaking.com/refactoring/smells/feature-envy), where they need to access another component's internal data to work.

Here stands the question, what's the criteria to define what's the main goal of the application? When something is provided to the user, that is part of the application functionalities.



_Helper_: http://softwareengineering.stackexchange.com/questions/247267/what-is-a-helper-is-it-a-design-pattern-is-it-an-algorithm

> some miscellaneous, commonly used operations and attempted to make them reusable by lumping them together in an unnatural grouping.

**Bibliography**

Cwalina, Krzysztof. 2009. __Framework Design Guidelines: Conventions, Idioms, and Patterns for Reusable .NET Libraries, Second Edition_. Boston: Pearson Education, Inc. 206.