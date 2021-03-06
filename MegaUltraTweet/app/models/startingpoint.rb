class Startingpoint < ActiveRecord::Base
  has_and_belongs_to_many :hashtags

  # Search terms that are used for scraping twitter
  # Output as Array of Strings
  def get_start
    out = []
    self.hashtags.to_a.each { |t| out.push(t.get_text) }
    return out
  end

  def get_number_of_hashtags
    return self.hashtags.to_a.size
  end

  def add_popular_hashtags(number)
    hashtags = Hashtag.all
    hashtags = hashtags.sort_by{ |hashtag| hashtag.get_rank }.reverse
    hashtags.first(number).each { |hashtag| self.hashtags<<hashtag unless self.hashtags.include?(hashtag) }
  end

  def remove_unpopular_hashtags(number)
    hashtags = self.hashtags.sort_by{ |hashtag| hashtag.get_rank}.reverse
    hashtags.last(number).each { |hashtag| self.hashtags.delete(hashtag) }
  end

  # If a hashtag is re-added, a less popular one is removed
  def repair_defaults
    MegaUltraTweet::Application::DEFAULT_STARTING_VALUES.each do |s|
      hashtag = Hashtag.find_by_text("##{s}")
      if !self.hashtags.exists?(hashtag.id)
        self.hashtags<<hashtag
        self.remove_unpopular_hashtags(1)
      end
    end
  end

end
