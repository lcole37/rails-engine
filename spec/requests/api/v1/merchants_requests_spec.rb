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
end
