require 'rails_helper'

RSpec.describe FoodsController, type: :controller do
	 before do
  		allow(controller).to receive(:authenticate_request) 
     end
	describe "GET #index" do
	    it "returns a success response" do
	      get :index
	      expect(response).to have_http_status(200)
	    end
    end

    describe "GET #search_food" do
    context "when search parameter is present" do
      it "returns matching foods as JSON" do
      	 category = FactoryBot.create(:category)
        food = FactoryBot.create(:food, name: "Pizza", category: category)
        get :search_food, params: { search: "Pizza" }
        expect(response).to have_http_status(:success)
        expect(response.body).to include(food.to_json)
      end

      it "returns status :not_found if no matching foods found" do
        get :search_food, params: { search: "Nonexistent Food" }
        expect(response).to have_http_status(:not_found)
        expect(response.body).to include("No matching foods found")
      end
    end
end
end