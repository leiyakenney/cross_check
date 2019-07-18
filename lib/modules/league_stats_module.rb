module LeagueStats
  def convert_id_to_name(id)
    team = @teams.find {|team| team.team_id == id}
    team.team_name
  end

  def team_vs_goals
    team_vs_goals_data = Hash.new(0)
    @games.each do |game|
      team_vs_goals_data[game.home_team_id] += game.home_goals
    end
    team_vs_goals_data
  end

  def games_played
    games_played_data = Hash.new(0)
    @games.each do |game|
      games_played_data[game.home_team_id] += 1
    end
    games_played_data
  end

  def highest_scoring_home_team
    high_team = team_vs_goals.max_by do |team, goals|
          (goals.to_f / games_played[team])
      end
    convert_id_to_name(high_team[0])
  end

  def lowest_scoring_home_team
    low_team = team_vs_goals.min_by do |team, goals|
          (goals.to_f / games_played[team])
      end
    convert_id_to_name(low_team[0])
  end

  def count_of_teams
    @teams.count {|team| team.team_id}
  end
end
