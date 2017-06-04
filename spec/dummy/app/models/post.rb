class Post < ApplicationRecord
  belongs_to :user, inverse_of: :posts

  def to_s
    title
  end
end
