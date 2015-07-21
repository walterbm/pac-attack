require 'open-uri'
require 'json'
require 'pry-byebug'

require_relative 'keys'

api_key = FEC_API_KEY 
api_request ="https://api.open.fec.gov/v1/names/candidates?api_key=#{FEC_API_KEY}&q=Hillary"
api_response = open(api_request).read
json_result = JSON.parse(api_response)

# FEC_API does not support requests for individual donations!

# Obama FEC id: P80003338

# Romney FEC id: P80003353

# Hillary FEC id: P00003392

# "COALITION FOR CHANGE" FEC id: C00450809
# "ROMNEY FOR PRESIDENT, INC." FEC id: C00431171
# "Hillary for AMERIC" FEC id: C00575795


# get candidate
# get all committes for candiate
# find invidual contributions to pac
# show