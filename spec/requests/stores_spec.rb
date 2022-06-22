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
    it "routes /inventory to stores index" do
      get "/api/v1/inventory"
      expect(response).to have_http_status(:found)
    end
  end

  describe "GET /alerts" do
    it "routes /alerts to stores index" do
      Store.create(name: 'Empty', model: "Model A", inventory: 0, status: :empty)
      Store.create(name: 'Warning', model: "Model B", inventory: 20, status: :warning)
      Store.create(name: 'Attention', model: "Model C", inventory: 80, status: :attention)
      Store.create(name: 'Full', model: "Model D", inventory: 100, status: :full)

      get "/api/v1/alerts"
      json = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(json['message']).to eq("Stores that need attention with their inventory!")
      expect(json['stores'].length).to eq(4)
    end

    it "returns error" do
      get "/api/v1/alerts"
      expect(response).to have_http_status(:not_found)
      expect(response.body).to eq("{\"error\":\"No alerts were created for the stores saved!\"}")
    end
  end
end
