require 'rubygems'
require 'campaign_cash'
require 'pry'
include CampaignCash

Base.api_key = "f00fe1ee06f70d27bd59eca0c5382c5f:10:72490814"
binding.pry
Candidate.search("Bass", 2012).first.name