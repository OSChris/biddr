class BidsController < ApplicationController

  before_action :find_auction

  def create
    @bid = @auction.bids.new(bids_params)
    @bid.user = current_user
    if @bid.save
      redirect_to @auction, notice: "Bid posted!"
    else
      render "auctions/show"
      flash.now[:alert] = "There was a problem posting your bid."
    end
  end

  private

  def find_auction
    @auction = Auction.find params[:auction_id]
  end

  def bids_params
    params.require(:bid).permit(:amount)
  end
end
