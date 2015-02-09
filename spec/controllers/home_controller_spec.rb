require 'spec_helper'

describe HomeController do

  render_views

  describe "GET 'index'" do
    it "should be successful without log in" do
      get 'index'
      expect(response.body).to match /Log in to continue/m
    end

    it "should be redirect with log in" do
      sign_in FactoryGirl.create(:user)
      get 'index'
      expect(response).to redirect_to(money_index_path)
    end
  end

end
