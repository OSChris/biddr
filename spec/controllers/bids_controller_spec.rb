require 'rails_helper'

RSpec.describe BidsController, :type => :controller do

  let(:user) { create(:user) }
  let(:auction) {create(:auction)}

  describe "#create" do 

    context "with a signed in user" do 
      before {sign_in user}
      context "with a valid request" do 
        
        def valid_request
          post :create, auction_id: auction.id, bid: { amount: 100 }
        end

        it "adds a bid associated with the auction to the database" do 
          expect{ valid_request }.to change{auction.bids.count}.by(1)
        end

        it "redirects to the auction show page" do 
          valid_request
          expect(response).to redirect_to auction_path(auction)
        end
      end

      context "with invalid request" do 
        def invalid_request
          post :create, auction_id: auction.id, bid: { amount: -12 }
        end

        it "doesn't create a new record in the database" do 
          expect{invalid_request}.to_not change{auction.bids.count}
        end

      end

    end

    context "no signed in user" do 

    end

  end

end
