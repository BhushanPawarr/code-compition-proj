require 'rails_helper'
RSpec.describe UserBlock::User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:role) }
    it { should validate_presence_of(:mobile_number) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_uniqueness_of(:mobile_number) }

    it 'validates email format' do
      should allow_value('test@example.com').for(:email)
      should_not allow_value('invalid_email').for(:email)
    end
  end

  describe 'enums' do
    it { should define_enum_for(:role).with_values(['admin', 'customer', 'seller']) }
  end
end
