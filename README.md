http://bepos.be

Static blog generated with [Nanoc](http://nanoc.ws/)

Written with ♥ by [EmAK](http://twitter.com/em_hack) under CC-BY.

### To Do - **functionnalities**
[] *Article unique #ID*
		*Given* some articles were published on my blog
		*When* I visit one article
		*Then* I should see a unique URL
			*And* it should contain the article #id

[] *Published articles overview*
		*Given* some articles were published on my blog
			*And* each article have a title
			*And* each article takes time_to_read
			*And* each article have a date of publication
		*When* I visit the home page
		*Then* I should see the titles of the last articles published
			*And* they should be ordered by the date of publication (latest at the top)
			*And* I should find a link to the article
			*And* I should see the time_to_read the article

[] *Information about publication date
		*Given* some articles were published on my blog
		*When* I read one article
		*Then* I should see the date of publication

[] *Discuss about the article
		*Given* some articles were published on my blog
		*When* I read one article
		*Then* I should see the author's twitter @ID
			*And* the #twitter_tag of the article
			*And* a link to the #twitter_tag query on twitter.com
