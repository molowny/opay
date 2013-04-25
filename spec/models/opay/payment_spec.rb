require 'spec_helper'

module Opay
  describe Payment do

    describe 'associations' do
      it { should belong_to(:payable) }
    end

    specify 'validations' do
      should validate_presence_of(:payable)
      should validate_presence_of(:provider)
      should validate_presence_of(:amount)
    end

  end
end
