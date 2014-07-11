class AuctionsController < ApplicationController

  before_action :find_auction, except: [:index, :new, :create]

  def index
    @auctions = Auction.all
  end

  def show
  end

  def new
    @auction = Auction.new
  end

  def create
    @auction = Auction.new(auction_params)
    @auction.user = current_user
    if @auction.save
      redirect_to @auction, notice: "Auction created!"
    else
      render :new
      flash.now[:alert] = "Nope."
    end
  end

  def edit
  end

  def update

  end

  def destroy
    @auction.destroy
    redirect_to auctions_path, notice: "Auction deleted!"
  end

  private

  def auction_params
    params.require(:auction).permit(:title, :details, :end_date, :reserve)
  end

  def find_auction
    @auction = Auction.find params[:id]
  end

end
