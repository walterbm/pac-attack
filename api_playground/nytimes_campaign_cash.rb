require 'rubygems'
require 'campaign_cash'
include CampaignCash

require 'pry-byebug'

require_relative 'keys'

Base.api_key = NYT_API_KEY

Candidate.search("Bass", 2012).first.name
IndependentExpenditure.latest