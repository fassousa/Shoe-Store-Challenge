require 'rails_helper'

RSpec.describe "Api::V1::StoresController", type: :request do
  describe "GET /index" do

    it 'returns a list of stores' do
      Store.create(name: 'Store 1', model: "Model A", inventory: 10)

      get "/api/v1/stores"
      json = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(json[0]['name']).to eq("Store 1")
      expect(json[0]['model']).to eq("Model A")
      expect(json[0]['inventory']).to eq(10)
    end

    it 'returns error' do
      get "/api/v1/stores"
      expect(response).to have_http_status(:not_found)
      expect(response.body).to eq("{\"error\":\"No stores found\"}")
    end
  end

  describe "GET /inventory" do

  end

  describe "GET /alerts" do
    
  end
end
