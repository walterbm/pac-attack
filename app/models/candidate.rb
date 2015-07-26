class Candidate

  def committees
    Committee.for(self.candidate_id)
  end

  def self.search(name)
    results = FEC.candidate_search(name)
    results.collect do |candidate_attributes|
      self.new(candidate_attributes)
    end
  end

  def self.find(fec_id)
    candidate_attributes = FEC.candidate_find(fec_id)
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
      children: prepared_committees_hash
    }
  end

  private

    def prepared_committees_hash
      self.committees.collect do |committee|
        donors = prepared_donors(committee)
        money = committee.money
        Hash.new.tap do |hash|
          hash[:name] = "#{committee.name} | $#{money}"
          donors.empty? ? hash[:size] = money : hash[:children] = donors
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

