class Post < ApplicationRecord
  belongs_to :user
  
  validates :title,presence: true, length: {maximum: 100}
  validates :comment,presence: true, length: {maximum: 255}
  #画像投稿
  mount_uploader :image, ImageUploader
  
  #お気に入りの中間テーブルと繋ぎその先のuserテーブルと繋がる
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites
end
