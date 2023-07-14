require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships'
  it { should belong_to(:merchant) }

  describe 'validations'
  it { should validate_presence_of(:name) }
end
