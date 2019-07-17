class Team

  attr_reader :data, :team_id

  def initialize(data = [])
    @data = data
    @team_id = data['team_id']
    @franchise_id = data['franchiseid']
    @short_name = data['shortName']
    @team_name = data['teamName']

  end
end
