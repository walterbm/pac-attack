class Committee
  FEC_API_KEY = ENV["fec_key"]

  def self.for(candidate_id)
    results = FEC.request("candidate/#{candidate_id}/committees?api_key=#{FEC_API_KEY}&sort_hide_null=true&sort=name&per_page=100&page=1")
    results.collect do |committee_attributes|
      self.new(committee_attributes)
    end
  end

  def initialize(committee_attributes)
    committee_attributes.each do |attribute, value|
      if value
        self.class.send(:attr_accessor, "#{attribute}")
        self.send("#{attribute}=", value)
      end
    end
  end

  def money
    results = FEC.request("committee/#{self.committee_id}/reports?api_key=#{FEC_API_KEY}&sort_hide_null=true&sort=-coverage_end_date&per_page=1&page=1")
    (results.empty? || results.first["total_disbursements_ytd"].nil?) ? 0 : results.first["total_disbursements_ytd"].abs 
  end

  def donors       
    results = FEC.request("committee/#{self.committee_id}/schedules/schedule_a/by_contributor?api_key=#{FEC_API_KEY}&sort_hide_null=true&sort=total&per_page=50&page=1")
    donor = Struct.new(:contributor_id, :name, :total)
    results.collect do |record|
      donor.new(record["contributor_id"],record["contributor_name"],record["total"])
    end
  end

end
