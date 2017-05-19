class Order < ApplicationRecord
  validates :billing_name, presence: true
  validates :billing_address, presence: true
  validates :shipping_name, presence: true
  validates_presence_of :shipping_address

  belongs_to :user
  has_many :product_lists

  before_create :generate_token

  def generate_token
    self.token = SecureRandom.uuid
  end

  def pay!(method)
    self.update_columns(:is_paid => true )
    self.update_columns(:payment_method => method)
  end


end
