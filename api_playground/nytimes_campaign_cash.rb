require 'rubygems'
require 'campaign_cash'
include CampaignCash

require 'pry'

require_relative 'keys'

Base.api_key = NYT_API_KEY
binding.pry
Candidate.search("Bass", 2012).first.name