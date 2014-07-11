class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :auction

  validates :amount, numericality: { greater_than: :auction_current_price }


  after_save :update_current_price

  def auction_current_price
    self.auction.current_price
  end

  private

  def update_current_price
    self.auction.set_current_price
  end
end
