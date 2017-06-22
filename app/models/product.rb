class Product < ApplicationRecord
  validates :price, presence: true
  validates :title, presence: true
  has_many :favorites
  has_many :users, through: :favorites , source: :user
  has_many :cart_items
  has_many :reviews
  has_many :photos
  accepts_nested_attributes_for :photos
  before_validation :generate_friendly_id, :on => :create
  validates_presence_of :title, :friendly_id

  validates_uniqueness_of :friendly_id
  validates_format_of :friendly_id, :with => /\A[a-z0-9\-]\z/

  mount_uploader :image, ImageUploader

  def to_param
    self.friendly_id
  end

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

  protected

  def generate_friendly_id
    self.friendly_id ||= SecureRandom.uuid
  end

end
