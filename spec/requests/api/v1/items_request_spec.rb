require 'rails_helper'


describe " Items API" do
  it "can send a list of items" do
    create_list(:item, 7)

    get "/api/v1/items"

    expect(response).to be_successful

    items_response = JSON.parse(response.body, symbolize_names: true)
    items = items_response[:data]

    expect(items.count).to eq(7)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_an(String)
      # require "pry"; binding.pry

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_an(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_an(Float)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_an(Integer)
    end
  end

  it "can return a individual items" do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    expect(response).to be_successful

    item_response = JSON.parse(response.body, symbolize_names: true)
    item = item_response[:data]

    # require "pry"; binding.pry
    expect(item).to have_key(:id)
    expect(item[:id]).to be_an(String)
    expect(item[:id]).to eq("#{id}")

    expect(item[:attributes]).to have_key(:description)
    expect(item[:attributes][:description]).to be_an(String)

    expect(item[:attributes]).to have_key(:unit_price)
    expect(item[:attributes][:unit_price]).to be_an(Float)

    expect(item[:attributes]).to have_key(:merchant_id)
    expect(item[:attributes][:merchant_id]).to be_an(Integer)
  end

  it 'can return items for given merchant' do
    @merchant = create(:merchant)
    items = create_list(:item, 3, merchant: @merchant)

    # get "/api/v1/merchants/#{@merchant.id}/items"
    get api_v1_merchant_items_path(@merchant.id)

    expect(response).to be_successful

    items_response = JSON.parse(response.body, symbolize_names: true)

    items = items_response[:data]
    # require "pry"; binding.pry

    expect(items.count).to eq(3)

    items.each do |item|
      expect(item[:id]).to be_a(String)
      expect(item[:attributes][:name]).to be_a(String)
      expect(item[:attributes][:description]).to be_a(String)
      expect(item[:attributes][:unit_price]).to be_a(Float)
      expect(item[:attributes][:merchant_id]).to be_a(Integer)
    end
  end

  it "can create a new item and delete it" do
    #items create
  end
end
