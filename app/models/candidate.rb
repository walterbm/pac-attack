class Candidate
  FEC_API_KEY = ENV["fec_key"]
  @@all = []

  def committees
    Committee.for(self.candidate_id)
  end

  def self.search(name)
    results = FEC.request("candidates/search?api_key=#{FEC_API_KEY}&office=P&name=#{name}&per_page=100&page=1")
    results.collect do |candidate_attributes|
      self.new(candidate_attributes)
    end
  end

  def self.find(fec_id)
    candidate_attributes = FEC.request("candidate/#{fec_id}?api_key=#{FEC_API_KEY}&sort=-expire_date&sort_hide_null=false&page=1&per_page=20")
    self.new(candidate_attributes.first)
  end

  def initialize(candidate_attributes)
    candidate_attributes.each do |attribute, value|
      self.class.send(:attr_accessor, "#{attribute}")
      self.send("#{attribute}=", value)
    end
    @@all << self
  end

  def generate_d3_hash
    
  end

end

