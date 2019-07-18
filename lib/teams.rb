class Team

  attr_reader :data, :team_id, :franchise_id, :short_name, :team_name, :abbreviation, :link

  def initialize(data)
    @team_id = data['team_id'].to_i
    @franchise_id = data['franchiseid'].to_i
    @short_name = data['shortName']
    @team_name = data['teamName']
    @abbreviation = data['abbreviation']
    @link = data['link']
  end
end

#symbolconverter squashes all names to downcase
