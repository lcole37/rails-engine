require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
  end
  describe "relationships" do
    it { should have_many :items }
    it { should have_many(:invoice_items).through(:items) }
    it {should have_many(:invoices).through(:invoice_items)}
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end
  describe 'class methods' do
    describe 'find_merchant' do
      it "finds one merchant" do
        merchant_1 = create(:merchant, name: "Mary")
        merchant_2 = create(:merchant, name: "Larry")
        merchant_3 = create(:merchant, name: "Harry")
        merchant_4 = create(:merchant, name: "Sherri")
        merchant_5 = create(:merchant, name: "Maryanne")
        merchant_6 = create(:merchant, name: "Sherice")

        expect(Merchant.find_merchant("ary")).to eq(merchant_1)
        expect(Merchant.find_merchant("sher")).to eq(merchant_6)
      end
    end
  end
end
