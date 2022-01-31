class Book < ApplicationRecord
 belongs_to :user
 #↓を書き忘れたらundefined local variable or method `favorites' for #<Book:0x00007f1ac40cd510>
 has_many :favorites
 has_many :book_comments, dependent: :destroy

  validates :title, presence: true

  #バリデーション、複数指定する時ルールをカンマで区切る
  validates :body,  length: {maximum: 200}, presence: true

  #引数で渡されたユーザーidがFavoritesテーブル内に存在するかどうか調べる


  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end


end
