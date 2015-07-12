require 'rubygems'
require 'campaign_cash'
include CampaignCash

require 'pry'

require_relative 'api_playground/keys'

Base.api_key = API_KEY['NYT']
binding.pry
Candidate.search("Bass", 2012).first.name