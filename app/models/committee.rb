class Committee

  def self.for(candidate_id)
    results = FEC.committees_for(candidate_id)
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
    results = FEC.committee_money(self.committee_id)
    (results.empty? || results.first["total_disbursements_ytd"].nil?) ? 0 : results.first["total_disbursements_ytd"].abs 
  end

  def donors       
    results = FEC.committee_donors(self.committee_id)
    donor = Struct.new(:contributor_id, :name, :total)
    results.collect do |record|
      donor.new(record["contributor_id"],record["contributor_name"],record["total"])
    end
  end

end
