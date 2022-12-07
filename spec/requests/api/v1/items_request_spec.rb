# require 'rails_helper'
#
#
# describe " Items API" do
#   it "can return a list of merchant's items" do
#     id = create(:merchant).id
#     create_list(:item, 7)
#
#     get "/api/v1/merchants/#{id}/items"
#
#     expect(response).to be_successful
#     # require "pry"; binding.pry
#     response_body = JSON.parse(response.body, symbolize_names: true)
#     merchant = response_body[:data]
#
#     expect(merchant).to have_key(:id)
#     expect(response_body.count).to eq(7)
#     expect(merchant[:id]).to be_a(String)
#     expect(merchant[:attributes][:name]).to be_a(String)
  # end
