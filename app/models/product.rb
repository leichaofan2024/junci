class Product < ApplicationRecord
  validates :price, presence: true
  validates :title, presence: true
  has_many :favorites
  has_many :users, through: :favorites , source: :user
  has_many :cart_items
  has_many :reviews
  has_many :photos
  accepts_nested_attributes_for :photos

  mount_uploader :image, ImageUploader


  def is_favorited?(user)
    self.users.include?(user)
  end


  def add_to_favorite!(user)
    self.users << user
    self.save

  end

  def quit_favorite!(user)
    self.users.delete(user)
    self.save
  end
  scope :recent, -> {order("created_at DESC")}
end
