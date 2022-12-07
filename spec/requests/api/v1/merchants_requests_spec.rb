require 'rails_helper'

describe "Merchants API" do
  it "sends a list of Merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful
    # require "pry"; binding.pry
    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants).to be_a(Array)
    expect(merchants.count).to eq(3)
  end

  it "can get one merchant by its ID" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(merchant).to have_key(:id)
    expect(merchant).to have_key(:name)
    expect(merchant[:name]).to be_a(String)
    expect(merchant[:id]).to be_an(Integer)
  end
end
