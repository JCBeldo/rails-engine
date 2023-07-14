require 'rails_helper'

describe 'Item Merchant API' do
  it 'sends back the merchant that created the item' do
    merch = create(:merchant)
    id = merch.id
    item = create(:item, merchant_id: id)

    get "/api/v1/items/#{item.id}/merchant"

    item_merchant_json = JSON.parse(response.body, symbolize_names: true)

    item_merchant = item_merchant_json[:data]

    expect(response).to be_successful

    expect(item_merchant).to have_key(:id)
    expect(item_merchant[:id]).to be_an(String)

    expect(item_merchant).to have_key(:attributes)
    expect(item_merchant[:attributes]).to be_an(Hash)
    expect(item_merchant[:attributes]).to have_key(:name)
    expect(item_merchant[:attributes][:name]).to eq(merch.name)
  end
end
