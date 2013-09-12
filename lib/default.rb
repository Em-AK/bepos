# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.
include Nanoc3::Helpers::Blogging
include Nanoc3::Helpers::Tagging
include Nanoc3::Helpers::Rendering
include Nanoc3::Helpers::LinkTo

module PostHelper

	# Human readable date from timestamp
  def get_pretty_date(post)
    attribute_to_time(post[:created_at]).strftime('%B %-d, %Y')
  end

  # Estimation of the time to read a post
  def get_reading_time(post)
  	words_per_minute = 170.0
  	time = post.raw_content.split.length / words_per_minute
  	reading_time = "~ #{time.round}"
  	if time < 1
  		reading_time = "< 1"
  	elsif time >= 1 && time < 1.6
  		reading_time = "~ 1"
  	end
  	reading_time
	end
end

include PostHelper
