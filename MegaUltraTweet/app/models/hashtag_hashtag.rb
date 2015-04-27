class HashtagHashtag < ActiveRecord::Base
  belongs_to :hashtag_first, class_name: :Hashtag, foreign_key: :hashtag_first_id
  belongs_to :hashtag_second, class_name: :Hashtag, foreign_key: :hashtag_second_id
  has_one :popularity, as: :popular

end