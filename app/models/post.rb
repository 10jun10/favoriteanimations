class Post < ApplicationRecord
  belongs_to :user
  
  validates :title,presence: true, length: {maximum: 100}
  validates :comment,presence: true, length: {maximum: 255}
  #画像投稿
  mount_uploader :image, ImageUploader
  
  #お気に入りの中間テーブルと繋ぎその先のuserテーブルと繋がる
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites
  
  def self.search(search) #ここでのself.はPost.を意味する
    if search
      where(['title LIKE ?', "%#{search}%"]) #検索とpostの部分一致を表示。User.は省略
    else
      all #全て表示。Post.は省略
    end
  end
end
