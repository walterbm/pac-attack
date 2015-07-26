class Candidate
  FEC_API_KEY = ENV["fec_key"]

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
  end

  def image_url
    Google::Search::Image.new(:query => "#{self.pretty_print_name} #{self.election_years.last}").first.uri
  end

  def pretty_print_name
    name = self.name.split(', ') 
    "#{name.last.capitalize} #{name.first.capitalize}"
  end

  def party_color
    party_colors = {
      "DEM" => "primary",
      "REP" => "danger",
      "IND" => "warning",
      "GRE" => "success"
    }
    if party_colors.has_key?(self.party)
      party_colors[self.party]
    else
      "default"
    end
  end

  def d3_colors
    party_colors = {
      "DEM" => ["rgb(0,137,255)", "rgb(30,60,130)"],
      "REP" => ["rgb(255,64,0)", "rgb(130,10,24)"]
    }
    if party_colors.has_key?(self.party)
      party_colors[self.party]
    else
      ["hsl(152,80%,80%)", "hsl(228,30%,40%)"]
    end

  end

  def d3_hash
    {
      name: self.name,
      children: prepared_committees
    }
  end

  private

    def prepared_committees
      self.committees.collect do |committee|
        donors = prepared_donors(committee)
        Hash.new.tap do |hash|
          hash[:name] = "#{committee.name} | $#{committee.money}"
          donors.empty? ? hash[:size] = committee.money : hash[:children] = donors
        end
      end
    end

    def prepared_donors(committee)
      committee.donors.map do |donor| 
        {
          name: donor.name,
          size: donor.total
        }
      end
    end

end

