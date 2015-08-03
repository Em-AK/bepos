---
title: My journey into software architecture with ruby
created_at: {}
kind: article
lang: en
published: true
---


*As a ruby practitioner here is a report on how I began my journey into software architecture over the course of a weekend.*

I am currently working on a web application with Rails. As the application grows, my ActiveRecord (AR) models grow with all the business logic in it. It is evident by reading the tests linked to these models that my classes violate the S of the [SOLID](https://goo.gl/9b6xB6) principles.

After a few searches it seems that my problem is very common and well known by the more experienced rubyists : I developed the Rails app syndrom.

## ActiveRecord all the things

{:refdef: .picture}
![Sponge Bob](../../img/3-spongebob-computer.jpg)
{: refdef}

The most extreme example I found is a class derived from AR that have no state to save in the database. The `SpongeBob` class whose reponsibility is to instanciate other AR objects by parsing the content of a markdown string and to persist the state of those objects into the database. For sure there is no point for `SpongeBob` himself to inherit from AR. 

Looking for inspiration I began to search for 'service object'.

## From `SpongeBob` to Uncle Bob

My [first hit](https://sporto.github.io/blog/2012/11/15/a-pattern-for-service-objects-in-rails/) although not very convincing brought me to two very interesting resources :
  * [7 Patterns to Refactor Fat ActiveRecord Models](http://blog.codeclimate.com/blog/2012/10/17/7-ways-to-decompose-fat-activerecord-models/)
  * and somewhere in the comments a [conference by Uncle Bob from 2011 : "Architecture the Lost Years" (~1h)](https://youtu.be/WpkDN78P884). 

During his show Robert passes a few messages:

> The web is a delivery mechanism

> The top level architecture should reflect the intent of an application

What I like is the boundary he draws around the application. As an engineer I like to think about systems by first defining their boudaries, then it's easy to observe what flows in and out and to understand the behaviour and responsibility/authority of the system. To have the application being able to live on its own, decoupled from the web framework and the database sounds like a dream to my Rails oriented mind. But what a nice dream to have.

At the end of the talk I had more questions than answers. Why everyone seems to continue to live inside Rails ? How to properly turn Rails into a plugin of my application ? 4 years after *the lost years* where are the working implementations of these ideas ?

## Go read some code

I found a first implementation in the [Obvious gem](http://retromocha.com/obvious/) by Brian Knapp wich is a guide to implement the [clean architecture](http://blog.8thlight.com/uncle-bob/2012/08/13/the-clean-architecture.html). Awesome! now all this stuff has a name :)

It wasn't long before I crossed the path of [Trailblazer](http://trailblazerb.org/) which seems to be a very comprehensive set of components in which Rails can be easily plugged in. Nick Sutterer even wrote [a whole book](https://leanpub.com/trailblazer) about it. Clean. isn't it?

Then I remembered about [Lotus](http://lotusrb.org/) a complete web framework combining 7 specialized frameworks, with more of them comming soon. The Lotus guides introduce the [Container architecture](http://lotusrb.org/guides/architectures/container/)

  > Lotus Container arch is heavily inspired by Clean Architecture.
 
I find it really nice to have a lightwheight and modular framework which is made to play nicely with the concepts of the Clean Architecture. I played with the *getting started guide* and it doesn't feels less productive/intuitive than the Rails way. By digging a little bit deeper in its APIs it may become my next framework of choice.

## It's only the beginning

That was a lot of stuff for me to digest in a single weekend. I am very happy with what I learned and the perspectives I gained.

Back to my current app, I will start small by extracting my application specific logic from my AR models into [Active Interactors](https://github.com/orgsync/active_interaction) or something similar.

Of course I continue to experiment with the Lotus framework. And may use it for a side project very (very) soon!

~ E.

*You can react, complement, question this article by pinging [@em_hack](https://twitter.com/em_hack) on twitter*
