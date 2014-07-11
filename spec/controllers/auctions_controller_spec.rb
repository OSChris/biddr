require 'rails_helper'

RSpec.describe AuctionsController, :type => :controller do

  describe "#create" do 

    let(:user) {create(:user)}

    context "signed in" do 
      before {sign_in user}
      context "with a valid request" do 

        def valid_request
          post :create, auction: { title: "My first auction",
                                   details: "deets",
                                   reserve: 25000,
                                   end_date: Time.now + 10.days }
        end

        it "creates a new record in the database" do 
          expect{valid_request}.to change{Auction.count}.by(1)
        end

        it "redirects to the show page" do 
          valid_request
          expect(response).to redirect_to auction_path(Auction.last)
        end

        it "sets a flash message" do 
          valid_request
          expect(flash[:notice]).to be
        end
      end

      context "with an invalid request" do 

        def invalid_request
          post :create, auction: { title: "",
                                   details: "deets",
                                   reserve: 25000,
                                   end_date: Time.now + 10.days }
        end

        it "doesn't create a new record in the database" do 
          expect{invalid_request}.to_not change{Auction.count}
        end

        it "renders the new page" do 
          invalid_request
          expect(response).to render_template(:new)
        end

        it "sets an alert message" do 
          invalid_request
          expect(flash[:alert]).to be
        end

      end
    end

    context "not signed in" do 
      it "should redirect to the sign-in page" do 
        post :create, auction: {title: "asdf",
                                details: "asdfsdf",
                                reserve: 2500,
                                end_date: Time.now + 2.days }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

  end

end
