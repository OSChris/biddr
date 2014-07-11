class AddCurrentPriceToAuctions < ActiveRecord::Migration
  def change
    add_column :auctions, :current_price, :integer, default: 1
  end
end
