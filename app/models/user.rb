class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_one_attached :profile_image
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy

  validates :name, {length: {in: 2..20} }
  validates :name, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  def get_profile_image(width, height)
    # profile_imageに画像がアタッチされてないなら実行
    unless profile_image.attached?
      # `app/assets/images/no_image.jpg`に格納されているファイルを`file_path`変数に格納する
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      # profile_imageに`file_path`に格納されているファイルを`default-image.jpg`という名前でjpgファイルとしてデータベースに保存する
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_fill: [width, height]).processed  #カリキュラムではresize_to_limitで画像サイズが変わるが、自身の環境では変わらず。。
  end                                                                 # resize_to_fill:にするとサイズが変わった。参考；https://qiita.com/tatsuhiko-nakayama/items/14324668e4b85e9271ee

  # hoge.variant()の記述
  # gem "image_processing"を用いて画像のリサイズを行うためには
  # variant()メソッドを呼び出す必要があります。


end
