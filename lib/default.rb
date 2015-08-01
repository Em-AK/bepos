# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.
include Nanoc3::Helpers::Blogging
include Nanoc3::Helpers::Tagging
include Nanoc3::Helpers::Rendering
include Nanoc3::Helpers::LinkTo

module PostHelper

  WORDS_PER_MINUTE = 300.0

  def get_pretty_date(post)
    attribute_to_time(post[:created_at]).strftime('%B %-d, %Y')
  end

  def short_date(post)
    attribute_to_time(post[:created_at]).strftime('%m/%Y')
  end

  def get_reading_time(post)
    minutes = post.raw_content.split.length / WORDS_PER_MINUTE
    if minutes < 1
      "< 1 min"
    elsif minutes >= 1 && minutes < 1.6
      "~ 1 min"
    else
      "~ #{minutes.round} min"
    end
  end
end

include PostHelper
