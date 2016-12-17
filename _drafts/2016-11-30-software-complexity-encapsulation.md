# Complexity in Software 2: Honor Thy Encapsulation

There are two types of complexity in software: real and perceived. Perceived complexity is the true holy grail of programming because, in the end, it's humans the ones that write and read code all day. It's virtually impossible, though, to have lower cognitive load unless your real complexity is also low.

In this series, we're discussing the various building blocks of software. This article focuses on the protagonist of our fight against complexity amongst components: encapsulation.

## A + B

Let's start by considering that our entire system has two only components, A and B. Component A knows some inner details of component B, and thus calls methods according to it. In some parts, it makes conditional statements after these implementation details.

One day, our client brings a new requirement, which forces us to change component B. We go for it and find out that now component A is broken (luckily via tests). We realize that instead of taking X minutes for the change, it's gonna take us X minutes multiplied by 2 because we to change not one component, but two. Talking money, if it'd cost us $1,000 to make a change, now the client will have to spend $2,000.

Is that either reasonable or acceptable? Obviously not. Software doesn't grow on its own, it's a result of our actions. Our client never intended to pay us to build a mess that'll hinder our own development.

Why did that happen? For one thing, lack of proper encapsulation. Had component A known nothing about B's internals, nothing of that would have happened, as we'd have changed B without any side-effects for A.

This is an example of how lack of seniority in a team can be a big burden for a company. Uncle Bob, in his Clean Coders series, mentions companies that went bankrupt because of their software. Kent Beck says:

> The complexity created by a programmer is in inverse proportion to their ability to handle it.

Kent Beck then goes on and draws conclusions from a particular experience:

> This programmer's lack of skill led him to choose a more complicated solution than necessary (the code was riddled with similar choices at all scales). At the same time, his lack of skill made him less capable of handling that additional complexity. Hence the irony: a more skilled programmer would choose a simpler solution, even though he would be able to make the more complicated solution work. The programmer least likely to be able to handle the extra complexity is exactly the one most likely to create it. Seems a little unfair.

## Breaking encapsulation

In Fundamental Of Object Oriented Design in UML, Meilir Page-Jones defines encapsulation.

Encapsulation is the grouping of related ideas into one unit, which can thereafter be referred to by a single name.

When objects start leaking implementation details to the outside world, complexity will arise. Consider the following image.

/images/software-complexity-encapsulation/module_encapsulation.png "breaking encapsulation"

In that case, object A, which is part of a module, breaks the 3rd module's encapsulation. Changing B leads to changes in A. In order to have proper encapsulation, we need to define clear interfaces. Component A needs to ask B for something (method call) and not care how it's done. Setters should be avoided.

## Patterns for Bad Encapsulation

It's very common to find all sorts of broken encapsulation in software. In a Rails project, it's common to see business logic entangled in Active Record classes. You basically have domain logic and tables logic in one place. If you have to change a domain logic, you have to also change the schema, and vice-versa. That's simply bad modelling.

If you ever use a setter or define an attribute of a component from the outside, you're breaking encapsulation. For instance, in user.state = "Available", you have the knowledge about the string Available that belongs solely to user and will probably be used at the database level (specially if you're in a Rails project). Instead, calling the method user.mark_as_available makes much more sense. If we need to change how this state is changed, we don't need to change anything except the mark_as_available method.

It's common in Rails projects to use patterns such as User.where("something = something_else") from controllers or service classes. How do you know the internal of the database to be able to pass that SQL parameters? What happens if you ever change the database? Or User? Instead, User.some_method is the way to go.

Keeping an eye on encapsulation will pay off every time, no matter the project, no matter the language. Remember,

> Isolation, where I refactor so the changes I want to make are less likely to affect areas I don't mean to change, buys peace of mind. [Kent Beck](https://twitter.com/KentBeck/status/424310922174148608)