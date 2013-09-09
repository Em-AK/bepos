# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.
include Nanoc3::Helpers::Blogging
include Nanoc3::Helpers::Tagging
include Nanoc3::Helpers::Rendering
include Nanoc3::Helpers::LinkTo

# Human readable date from timestamp
module PostHelper
  def get_pretty_date(post)
    attribute_to_time(post[:created_at]).strftime('%B %-d, %Y')
  end
end

include PostHelper
