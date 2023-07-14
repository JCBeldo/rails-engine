require 'rails_helper'

describe 'Merchant Items API' do
  it 'sends back the items belonging to a merchant' do
    id = create(:merchant, name: 'Shoppee').id
    items = create_list(:item, 5, merchant_id: id)

    get "/api/v1/merchants/#{id}/items"

    merchant_items_json = JSON.parse(response.body, symbolize_names: true)

    merchant_items = merchant_items_json[:data]

    expect(response).to be_successful
    expect(items.count).to eq(5)

    merchant_items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id].to_i).to be_an(Integer)

      expect(item).to have_key(:attributes)
      expect(item[:attributes]).to be_an(Hash)
      expect(item[:attributes]).to have_key(:name)
      expect(merchant_items.first[:attributes][:name]).to eq(items[0].name)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_an(String)
      expect(item[:attributes][:description]).to eq(items[0].description)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_an(Float)
      expect(merchant_items.first[:attributes][:unit_price]).to eq(items[0].unit_price)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_an(Integer)
      expect(item[:attributes][:merchant_id]).to eq(id)
    end
  end

  describe 'sad paths' do
    it 'will handle not having an merchant id' do

      get "/api/v1/merchants/0/items"

      item_merchant_json = JSON.parse(response.body, symbolize_names: true)

      item_merchant = item_merchant_json[:data]

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
    end
  end
end
