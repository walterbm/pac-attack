class Committee
  FEC_API_KEY = ENV["fec_key"]
  @@all = []

  def self.candidate_committees(candidate_id)
    api_request = "https://api.open.fec.gov/v1/candidate/#{candidate_id}/committees?api_key=#{FEC_API_KEY}&sort_hide_null=true&sort=name&per_page=100&page=1"
    api_response = open(api_request).read
    results = JSON.parse(api_response)["results"]

    results.each do |committee_attributes|
      self.new(committee_attributes)
    end
    @@all
  end

  def initialize(committee_attributes)
    committee_attributes.each do |attribute, value|
      if value
        self.class.send(:attr_accessor, "#{attribute}")
        self.send("#{attribute}=", value)
      end
    end
    @@all << self
  end

  def money
    api_request = "https://api.open.fec.gov/v1/committee/#{self.committee_id}/reports?api_key=#{FEC_API_KEY}&sort_hide_null=true&sort=-coverage_end_date&per_page=1&page=1"
    api_response = open(api_request).read
    results = JSON.parse(api_response)["results"]
    if results.empty? || results.first["total_disbursements_ytd"].nil?
      0
    else
      results.first["total_disbursements_ytd"]
    end
  end

  def donors       
    api_request = "https://api.open.fec.gov/v1/committee/#{self.committee_id}/schedules/schedule_a/by_contributor?api_key=#{FEC_API_KEY}&sort_hide_null=true&sort=total&per_page=50&page=1"
    api_response = open(api_request).read
    results = JSON.parse(api_response)["results"]
    results.collect do |record|
      {record["contributor_id"] => {donor_name: record["contributor_name"], donation_total: record["total"]} }
    end
  end

end
