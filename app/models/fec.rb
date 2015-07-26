class FEC
  FEC_API_KEY = ENV["fec_key"]

  def self.request(request_url)
    base_url = "https://api.open.fec.gov/v1/"
    api_request = base_url+request_url
    api_response = open(api_request).read
    JSON.parse(api_response)["results"]
  end

  def self.candidate_search(name)
    self.request("candidates/search?api_key=#{FEC_API_KEY}&office=P&name=#{name}&per_page=10&page=1")
  end

  def self.candidate_find(fec_id)
    self.request("candidate/#{fec_id}?api_key=#{FEC_API_KEY}&sort=-expire_date&sort_hide_null=false&page=1&per_page=5")
  end

  def self.committees_for(candidate_id)
    self.request("candidate/#{candidate_id}/committees?api_key=#{FEC_API_KEY}&sort_hide_null=true&sort=name&per_page=70&page=1")
  end

  def self.committee_money(committee_id)
    self.request("committee/#{committee_id}/reports?api_key=#{FEC_API_KEY}&sort_hide_null=true&sort=-coverage_end_date&per_page=1&page=1")
  end

  def self.committee_donors(committee_id)
    self.request("committee/#{committee_id}/schedules/schedule_a/by_contributor?api_key=#{FEC_API_KEY}&sort_hide_null=true&sort=total&per_page=50&page=1")
  end
  
end