require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships'
  it { should belong_to(:merchant) }
  it { should have_many(:invoice_items) }
  it { should have_many(:invoices).through(:invoice_items) }

  describe 'validations'
  it { should validate_presence_of(:name) }
end
