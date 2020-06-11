class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50}
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  #ユーザー画像アップロード
  mount_uploader :image_name, ImageUploader
  # 投稿機能との1対多の関係
  has_many :posts
  #お気に入りの中間テーブルと繋ぎその先のpostテーブルと繋がる
  has_many :favorites
  has_many :fav_posts, through: :favorites, source: :post
  
  #お気にいり用メソッド
  def like(post)
    favorites.find_or_create_by(post_id: post.id)
  end
  
  def unlike(post)
    favorite = favorites.find_by(post_id: post.id)
    favorite.destroy if favorites
  end
  
  def like?(post)
    fav_posts.include?(post)
  end
end
