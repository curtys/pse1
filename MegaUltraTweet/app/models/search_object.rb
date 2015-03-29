class SearchObject
  @searchTerms = []
  @tweets
  @hashtags = []

  def initialize(query)
    @searchTerms = query
  end

  def addTweets(tweets)
    @tweets = tweets
  end

  def addSearchTerms(terms)
    @searchTerms += terms
  end

  def getSearchTerms
    return @searchTerms
  end

  def setHashtags(hashtags)
    @hashtags = hashtags
  end

  def getHashtags
    return @hashtags
  end
end