require 'rails_helper'

describe "Merchants API" do
  it "sends a list of Merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful
    merchants_response = JSON.parse(response.body, symbolize_names: true)
    # require "pry"; binding.pry

    expect(merchants_response).to be_a(Hash)
    expect(merchants_response[:data].count).to eq(3)
  end

  it "can get one merchant by its ID" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    expect(response).to be_successful

    merchant_response = JSON.parse(response.body, symbolize_names: true)
    merchant = merchant_response[:data]

    expect(merchant).to have_key(:id)
    expect(merchant[:attributes]).to have_key(:name)
    expect(merchant[:attributes][:name]).to be_a(String)
    expect(merchant[:id]).to be_an(String)
  end
end
