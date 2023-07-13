require 'rails_helper'

describe 'Merchants API' do
  it 'sends a list of all merchants' do
    merch_1 = create(:merchant)
    merch_2 = create(:merchant)
    merch_3 = create(:merchant)

    get '/api/v1/merchants'

    merchants_json = JSON.parse(response.body, symbolize_names: true)

    merchants = merchants_json[:data]

    expect(response).to be_successful
    expect(merchants.count).to eq(3)

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id].to_i).to be_an(Integer)

      expect(merchant).to have_key(:attributes)
      expect(merchant[:attributes]).to be_an(Hash)
      expect(merchant[:attributes]).to have_key(:name)

      expect(merchants.first[:attributes][:name]).to eq(merch_1.name)
      expect(merchants.second[:attributes][:name]).to eq(merch_2.name)
      expect(merchants.last[:attributes][:name]).to eq(merch_3.name)
    end
  end

  it 'sends one merchant by its id' do
    merch = create(:merchant)
    id = merch.id

    get "/api/v1/merchants/#{id}"

    merchant_json = JSON.parse(response.body, symbolize_names: true)

    merchant = merchant_json[:data]

    expect(response).to be_successful

    expect(merchant).to have_key(:id)
    expect(merchant[:id].to_i).to eq(id)

    expect(merchant).to have_key(:attributes)
    expect(merchant[:attributes]).to be_an(Hash)
    expect(merchant[:attributes]).to have_key(:name)
    expect(merchant[:attributes][:name]).to eq(merch.name)
  end

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
end
