class Candidate
  FEC_API_KEY = ENV["fec_key"]
  @@all = []
  def self.search(name)
    # Currently limited to presidential candidates only!
    api_request = "https://api.open.fec.gov/v1/candidates/search?api_key=#{FEC_API_KEY}&office=P&name=#{name}&per_page=100&page=1"
    api_response = open(api_request).read
    results = JSON.parse(api_response)["results"]

    results.each do |candidate_attributes|
      self.new(candidate_attributes)
    end
    @@all
  end

  def initialize(candidate_attributes)
    candidate_attributes.each do |attribute, value|
      self.class.send(:attr_accessor, "#{attribute}")
      self.send("#{attribute}=", value)
    end
    @@all << self
  end

end

