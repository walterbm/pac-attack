class FEC
  FEC_API_KEY = ENV["fec_key"]

  def self.request(request_url)
    base_url = "https://api.open.fec.gov/v1/"
    api_request = base_url+request_url
    api_response = open(api_request).read
    JSON.parse(api_response)["results"]
  end
 
end