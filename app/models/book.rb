class Book < ApplicationRecord
 belongs_to :user
 has_many :favorites
 has_many :favorited_users, through: :favorites, source: :user
 has_many :book_comments, dependent: :destroy
 has_many :view_counts, dependent: :destroy

scope :created_today, -> { where(created_at: Time.zone.now.all_day) } # 今日
scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) } # 前日
scope :created_this_week, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) } #今週
scope :created_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) } #先週

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
