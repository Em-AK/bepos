http://bepos.be

Static blog generated with [Nanoc](http://nanoc.ws/)

Written with ♥ by [EmAK](https://twitter.com/em_hack) under CC-BY.

## To Do - **functionalities**

> ⊝ - not implemented  
> ✓ - done!

### ✓ Article unique #ID 

* *Given* some articles were published on my blog   
* *When* I visit one article   
* *Then* I should see a unique URL  
	* *And* it should contain the article #id

### ✓ Published articles overview
* *Given* some articles were published on my blog
	* *And* each article have a title
	* *And* each article have a date of publication
* *When* I visit the home page
* *Then* I should see the titles of the last articles published
	* *And* they should be ordered by the date of publication (latest at the top)
	* *And* I should find a link to the article

### ✓ Information about publication date
* *Given* some articles were published on my blog
* *When* I read one article
* *Then* I should see the date of publication

### ✓ Display time to read
* *Given* some articles were published on my blog
	* *And* each article takes time_to_read
* *When* I visit the home page
* *Then* I should see the time_to_read each article

### ⊝ RSS feed
* *Given* some articles were published on my blog
* *When* I visit any page
* *Then* I should find a link to the RSS feed of the blog

### ⊝ Discuss about the article
* *Given* some articles were published on my blog
* *When* I read one article
* *Then* I should see the author's twitter @ID
	* *And* the #twitter_tag of the article
	* *And* a link to the #twitter_tag query on twitter.com

### ⊝ Support french and english
* *Given* some articles were published on my blog
* *When* I visit the blog in english
* *Then* I should be able to switch from english to french

