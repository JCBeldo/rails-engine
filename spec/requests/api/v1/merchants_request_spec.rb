require 'rails_helper'

describe 'Merchants API' do
  it 'sends a list of all merchants' do
    merch_1 = create(:merchant)
    merch_2 = create(:merchant)
    merch_3 = create(:merchant)

    get '/api/v1/merchants'

    merchants_json = JSON.parse(response.body, symbolize_names: true)
    merchants = merchants_json[:data]
    # require 'pry'; binding.pry

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
end
