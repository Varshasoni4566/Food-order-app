require 'rails_helper'

RSpec.describe SearchController, type: :controller do

	describe "GET #search" do
	    it "returns a success response" do
	      get :search
	      expect(response).to have_http_status(200)
	    end
    end
end