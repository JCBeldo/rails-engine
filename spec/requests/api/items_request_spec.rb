require 'rails_helper'

describe 'Items API' do
  it 'sends a list of all items' do
    merch = create(:merchant)
    item_1 = create(:item, merchant_id: merch.id, name: 'headphones')
    item_2 = create(:item, merchant_id: merch.id, name: 'peanut butter')
    item_3 = create(:item, merchant_id: merch.id, name: 'takis')

    get '/api/v1/items'

    items_json = JSON.parse(response.body, symbolize_names: true)

    items = items_json[:data]

    expect(response).to be_successful
    expect(items.count).to eq(3)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id].to_i).to be_an(Integer)

      expect(item).to have_key(:attributes)
      expect(item[:attributes]).to be_an(Hash)
      expect(item[:attributes]).to have_key(:name)
      expect(items.first[:attributes][:name]).to eq('headphones')
      expect(items.second[:attributes][:name]).to eq('peanut butter')
      expect(items.last[:attributes][:name]).to eq('takis')

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_an(String)
      expect(item[:attributes][:description]).to eq(item_1.description)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_an(Float)
      expect(items[0][:attributes][:unit_price]).to eq(item_1.unit_price)
      expect(items[1][:attributes][:unit_price]).to eq(item_2.unit_price)
      expect(items[2][:attributes][:unit_price]).to eq(item_3.unit_price)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_an(Integer)
      expect(item[:attributes][:merchant_id]).to eq(merch.id)
    end
  end

  it 'sends one item by its id' do
    merch = create(:merchant)
    item_1 = create(:item, merchant_id: merch.id)
    id = item_1.id

    get "/api/v1/items/#{id}"

    item_json = JSON.parse(response.body, symbolize_names: true)

    item = item_json[:data]

    expect(response).to be_successful
    expect(response.status).to eq(200)

    expect(item).to have_key(:id)
    expect(item[:id].to_i).to eq(id)

    expect(item).to have_key(:attributes)
    expect(item[:attributes]).to be_an(Hash)

    expect(item[:attributes]).to have_key(:name)
    expect(item[:attributes][:name]).to be_an(String)
    expect(item[:attributes][:name]).to eq(item_1.name)

    expect(item[:attributes]).to have_key(:description)
    expect(item[:attributes][:description]).to be_an(String)
    expect(item[:attributes][:description]).to eq(item_1.description)

    expect(item[:attributes]).to have_key(:unit_price)
    expect(item[:attributes][:unit_price]).to be_an(Float)
    expect(item[:attributes][:unit_price]).to eq(item_1.unit_price)

    expect(item[:attributes]).to have_key(:merchant_id)
    expect(item[:attributes][:merchant_id]).to be_an(Integer)
    expect(item[:attributes][:merchant_id]).to eq(merch.id)
  end

  it 'creates a new item record' do
    merch = create(:merchant)
    item_params = {
      name: 'Barbells',
      description: '5kg weights to lift for exercise',
      unit_price: 5000,
      merchant_id: merch.id
      }

    headerz = { 'CONTENT_TYPE' => 'application/json' }

    post '/api/v1/items', headers: headerz, params: JSON.generate(item: item_params)

    created_item = Item.last

    expect(response).to be_successful

    expect(created_item.name).to eq(item_params[:name])
    # expect(item_params[:name]).to eq(created_item.name) Can write the reverse**
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.unit_price).to eq(item_params[:unit_price])
    expect(created_item.merchant_id).to eq(item_params[:merchant_id])
  end

  it 'destroys an existing item record' do
    merch = create(:merchant)
    item_1 = create(:item, merchant_id: merch.id)
    id = item_1.id

    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{id}"

    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect{Item.find(item_1.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
