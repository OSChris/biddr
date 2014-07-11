class BidsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_auction

  def create
    @bid = @auction.bids.new(bids_params)
    @bid.user = current_user
    if @auction.user == current_user
      redirect_to @auction, alert: "You can't bid on your own auction"
    else
      respond_to do |format|
        if @bid.save
          format.html { redirect_to @auction, notice: "Bid posted!" }
          format.js   { render }
        else
          format.html { flash.now[:alert] = "There was a problem posting your bid."
                        render "auctions/show" }
          format.js   { render }
        end
      end
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
