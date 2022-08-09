class Book < ApplicationRecord
 belongs_to :user
 has_many :favorites
 has_many :favorited_users, through: :favorites, source: :user
 has_many :book_comments, dependent: :destroy

  validates :title, presence: true
  validates :body,  length: {maximum: 200}, presence: true

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.last_week_favorite_rank
    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day
    self.includes(:favorited_users).sort {|a,b|
      b.favorited_users.includes(:favorites).where(created_at: from...to).size <=>
      a.favorited_users.includes(:favorites).where(created_at: from...to).size
    }
  end



end
