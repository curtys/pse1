class Startingpoint < ActiveRecord::Base
  has_and_belongs_to_many :hashtags

  # Search terms that are used for scraping twitter
  # Output as Array of Strings
  def get_start
    out = []
    self.hashtags.to_a.each { |t| out.push(t.get_text) }
    return out
  end

  def add_popular_hashtags(number)
    hashtags = Hashtag.all
    hashtags = hashtags.sort_by{ |hashtag| hashtag.get_rank }.reverse
    hashtags.first(number).each do |hashtag|
      if !@startingpoint.hashtags.include?(hashtag)
        @startingpoint.hashtags<<hashtag
      end
    end
  end

  def remove_unpopular_hashtags(number)
    hashtags = self.hashtags.sort_by{ |hashtag| hashtag.get_rank}.reverse
    hashtags.last(number).each do |hashtag|
      self.hashtags.delete(hashtag)
    end
  end

  # TODO: Re-add standard hashtags if not present

end
