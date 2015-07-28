require 'rubygems'
require 'campaign_cash'
include CampaignCash

require 'pry-byebug'

require_relative 'keys'

Base.api_key = NYT_API_KEY

test = Candidate.search("Bass", 2012).first.name
IndependentExpenditure.latest
results = IndividualContribution.committee("C00490045")
result2 = IndividualContribution.candidate("P80003338")
binding.pry

puts "hello"