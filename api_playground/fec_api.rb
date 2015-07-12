require 'open-uri'
require 'json'
require 'pry-byebug'

require_relative 'keys'

api_key = FEC_API_KEY 
api_request ="https://api.open.fec.gov/v1/names/candidates?api_key=#{FEC_API_KEY}&q=Hillary"
api_response = open(api_request).read
json_result = JSON.parse(api_response)

# FEC_API does not support requesting for individual donations!
