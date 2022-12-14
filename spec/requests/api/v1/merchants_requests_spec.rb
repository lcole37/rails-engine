require 'rails_helper'

describe "Merchants API" do
  it "sends a list of Merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful
    merchants_response = JSON.parse(response.body, symbolize_names: true)

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

  it "returns all items from the merchant" do
    id = create(:merchant).id
    create_list(:item, 5, merchant_id: id)

    get "/api/v1/merchants/#{id}/items"

    response_body = JSON.parse(response.body, symbolize_names: true)
    merchant_items = response_body[:data]

    expect(response).to be_successful

    merchant_items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(String)

      expect(item).to have_key(:type)
      expect(item[:type]).to eq('item')

      expect(item).to have_key(:attributes)
      expect(item[:attributes][:name]).to be_a(String)
      expect(item[:attributes]).to be_a(Hash)
      expect(item[:attributes][:description]).to be_a(String)
      expect(item[:attributes][:unit_price]).to be_a(Float)
      expect(item[:attributes][:merchant_id]).to be_a(Integer)
    end
  end

  it "can find first merchant" do
    create_list(:merchant, 5)

    merchant1 = Merchant.first
    merchant2 = Merchant.second
    merchant3 = Merchant.third

    get "/api/v1/merchants/find?name=#{merchant1.name}"

    expect(response).to be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)
    merchant = response_body[:data]

    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to be_a(String)
    expect(merchant[:id].to_i).to eq(merchant1.id)

    expect(merchant).to have_key(:attributes)
    expect(merchant[:attributes][:name]).to be_a(String)
    expect(merchant[:attributes][:name]).to eq(merchant1.name)
  end

  it "returns error message if no merchant matches search" do
    create_list(:merchant, 5)
    search_name = "fakename"

    get "/api/v1/merchants/find?name=#{search_name}"

    expect(response).to be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)
    merchant = response_body[:data]

    expect(merchant).to eq({:message => 'Merchant not found'})
  end
end
