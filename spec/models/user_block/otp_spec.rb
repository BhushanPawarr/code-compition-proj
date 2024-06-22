require 'rails_helper'
RSpec.describe UserBlock::Otp, type: :model do
  context 'validations' do
    it { should validate_presence_of(:otp_number) }
  end
end
