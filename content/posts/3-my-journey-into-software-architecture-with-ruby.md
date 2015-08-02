---
title: "My journey into software architecture with ruby"
created_at: 2015-08-02
kind: article
lang: en
---

* as a ruby practicionner here is a report on how I began my journey into software architecture over the course of a weekend.
* I am currently working on a web application with Rails. As the application grows, my ActiveRecord models grow with all the business logic in it. 
* Let's take an example. I have a `SpongeBob` class whose reponsibility is to create other AR objects from the content of a markdown file. We all agree that there is no point for `SpongeBob` to be an AR model himself. Looking for inspiration I began to search for 'service object'. 
* My [first hit](https://sporto.github.io/blog/2012/11/15/a-pattern-for-service-objects-in-rails/) brought me to two very interesting resources :
  * [7 Patterns to Refactor Fat ActiveRecord Models](http://blog.codeclimate.com/blog/2012/10/17/7-ways-to-decompose-fat-activerecord-models/)
  * and somewhere in the comments a [conference by Uncle Bob from 2011 - "Architecture the Lost Years" (~1h)](https://www.youtube.com/watch?t=174&v=WpkDN78P884). During this talk more questions than answers emerged in my mind.

* can I find some working code that implements those convincing ideas in an application plugged in Rails as the delivery framework ?
* First there is the [obvious gem](http://retromocha.com/obvious/) wich is a guide to implement the [clean architecture](http://blog.8thlight.com/uncle-bob/2012/08/13/the-clean-architecture.html) promoted by Uncle Bob.
* trailblazer wich seems to be a more comprehensive approach where Rails can easily be plugged in.
* 
* lotus.rb wich is a framework on its own, combining 7 components. The demo introduces the [Container architecture](http://lotusrb.org/guides/architectures/container/)
  > Lotus Container arch is heavily inspired by Clean Architecture.
  I like it, I can find indeed all the concepts introduced by Uncle Bob in his talk.

* Wow that's a lot of stuff to digest for a single weekend. For now I think I will start small by implementing ActiveInteractors into my app. I will also continue to experiment with the gems from the Lotus framework.


{:refdef: .picture}
![La prairie](../../img/2-prairie.jpg)
*Dernières roulades insouciantes dans l'herbe grasse*
{: refdef}

~ E.
