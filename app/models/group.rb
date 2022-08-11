class Group < ApplicationRecord
  has_many :group_users
  has_many :users, through: :group_users

  has_one_attached :image

  def get_group_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_fill: [width, height]).processed  #カリキュラムではresize_to_limitで画像サイズが変わるが、自身の環境では変わらず。。
  end
end
