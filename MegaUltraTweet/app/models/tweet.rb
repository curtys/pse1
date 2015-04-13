require 'link_thumbnailer'

class Tweet < ActiveRecord::Base
  belongs_to :author
  has_many :webpages
  has_and_belongs_to_many :hashtags

  def by_hashtags(hashtags)
    where(:hashtags => hashtags.map(:text))
  end

  def set_hashtags(hashtags_array)
    hashtags_array.each do |tag|
      if Hashtag.where(text: tag).blank?
        hashtag = Hashtag.create(text: tag)
      else
        hashtag = Hashtag.find_by_text(tag)
      end
      self.hashtags<<hashtag
    end
  end

  def set_webpages(webpages_array)
    webpages_array.each do |webpage|
      nailer = LinkThumbnailer.generate(webpage)
      puts "Inserting webpage into tweet"
      self.webpages.create(
          url: webpage,
          title: nailer.title,
          description: nailer.description
      )
    end if !webpages_array.nil?
  rescue LinkThumbnailer::Exceptions => e
    puts "Error in LinkThumbnailer"
    puts e
  rescue Net::HTTPExceptions => e
    puts "HTTP Error while thumbnailing"
    puts e
  end

  def get_webpages
    return self.webpages.to_a
  end

  def get_text
    return self.text
  end

  def get_hashtags
    return self.hashtags.to_a
  end

  def get_retweets_count
    return self.retweets
  end

  def get_author
    return self.author
  end

  def get_rank
    return self.get_author.get_followers_count + self.get_retweets_count
  end
end
