class User < ApplicationRecord
  has_many :posts, inverse_of: :user

  def to_s
    "#{first_name} #{last_name}"
  end
end
