require "rails_helper"
FEC_API_KEY = ENV["fec_key"]
RSpec.describe Committee, :type => :model do
  describe ".for" do 
    it "retrieves the appropriate candidate based on an id" do
      expect(FEC).to receive(:request).with("candidate/45/committees?api_key=#{FEC_API_KEY}&sort_hide_null=true&sort=name&per_page=100&page=1").and_return([])
      Committee.for(45)
    end
  end
end