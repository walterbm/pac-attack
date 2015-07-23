require_relative '../test_helper'

class FECTest < ActiveSupport::TestCase
  describe FEC do
    describe 'class methods' do
      describe ".request" do
        it 'makes an open_uri GET request' do
          fec_api = FEC
          fec_api.should_receive(:open)
        end
      end
    end
  end
end