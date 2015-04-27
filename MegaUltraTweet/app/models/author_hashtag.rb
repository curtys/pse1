class AuthorHashtag < ActiveRecord::Base
  belongs_to :author
  belongs_to :hashtag
  has_one :popularity, as: :popular

  def get_rank
    self.popularity.get_times_used
  end

  def set_rank(number)
    self.popularity.set_times_used(number)
  end

end
