class Article < ActiveRecord::Base
  def abbr_title(limit)
    if self.title.length < limit
      self.title
    else
      self.title[0..limit-4]+"..."
    end
  end
end
