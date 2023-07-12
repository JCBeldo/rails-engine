require 'rails_helper'

describe 'Merchants API' do
  it 'sends a list of all merchants' do
    create_list(:merchant, 5, name: 'Target')

    get '/api/v1/merchants'

    merchants_json = JSON.parse(response.body, symbolize_names: true)

    merchants = merchants_json[:data]

    expect(response).to be_successful
    expect(merchants.count).to eq(5)

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id].to_i).to be_an(Integer)

      expect(merchant).to have_key(:attributes)
      expect(merchant[:attributes]).to be_an(Hash)
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to eq('Target')
    end
  end

  it 'sends one merchant by its id' do
    id = create(:merchant, name: 'Dollar General').id

    get "/api/v1/merchants/#{id}"

    merchant_json = JSON.parse(response.body, symbolize_names: true)

    merchant = merchant_json[:data]

    expect(response).to be_successful

    expect(merchant).to have_key(:id)
    expect(merchant[:id].to_i).to eq(id)

    expect(merchant).to have_key(:attributes)
    expect(merchant[:attributes]).to be_an(Hash)
    expect(merchant[:attributes]).to have_key(:name)
    expect(merchant[:attributes][:name]).to eq('Dollar General')
  end

  it 'sends back the items belonging to a merchant' do
    id = create(:merchant, name: 'Shoppee').id
    items = create_list(:item, 5, merchant_id: id, name: 'Funky Stuff', unit_price: 5000)

    get "/api/v1/merchants/#{id}/items"

    merchant_items_json = JSON.parse(response.body, symbolize_names: true)

    merchant_items = merchant_items_json[:data]

    expect(response).to be_successful

    merchant_items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id].to_i).to be_an(Integer)

      expect(item).to have_key(:attributes)
      expect(item[:attributes]).to be_an(Hash)
      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes].first[1]).to eq(items[0].name)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_an(String)
      expect(item[:attributes][:description]).to eq(items[0].description)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_an(Float)
      expect(item[:attributes][:unit_price]).to eq(items[0].unit_price)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_an(Integer)
      expect(item[:attributes][:merchant_id]).to eq(id)
    end
  end
end
