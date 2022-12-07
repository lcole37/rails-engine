require 'rails_helper'


describe " Items API" do
  it "can send a list of items" do
    create_list(:item, 7)

    get "/api/v1/items"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items.count).to eq(7)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(Integer)

      expect(item).to have_key(:name)
      expect(item[:name]).to be_an(String)

      expect(item).to have_key(:description)
      expect(item[:description]).to be_an(String)

      expect(item).to have_key(:unit_price)
      expect(item[:unit_price]).to be_an(Float)

      expect(item).to have_key(:merchant_id)
      expect(item[:merchant_id]).to be_an(Integer)
    end
  end

  it "can return a individual items" do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    # require "pry"; binding.pry
    expect(item).to have_key(:id)
    expect(item[:id]).to be_an(Integer)
    expect(item[:id]).to eq(id)

    expect(item).to have_key(:description)
    expect(item[:description]).to be_an(String)

    expect(item).to have_key(:unit_price)
    expect(item[:unit_price]).to be_an(Float)

    expect(item).to have_key(:merchant_id)
    expect(item[:merchant_id]).to be_an(Integer)
  end

  it 'can return items for given merchant' do
    @merchant = create(:merchant)
    items = create_list(:item, 3, merchant: @merchant)

    # get "/api/v1/merchants/#{@merchant.id}/items"
    get api_v1_merchant_items_path(@merchant.id)

    expect(response).to be_successful

    items_response = JSON.parse(response.body, symbolize_names: true)

    # require "pry"; binding.pry

    expect(items_response.count).to eq(3)

    items_response.each do |item|
      expect(item[:id]).to be_a(Integer)
      expect(item[:name]).to be_a(String)
      expect(item[:description]).to be_a(String)
      expect(item[:merchant_id]).to be_a(Integer)
    end
  end

  it "can create a new item" do
    #items create
  end
end
