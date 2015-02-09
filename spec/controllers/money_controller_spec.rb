require 'spec_helper'

describe MoneyController do

  describe "GET 'index'" do

    it "renders the index template" do
      sign_in FactoryGirl.create(:user)
      get :index
      expect(response).to render_template("index")
    end

  end
end