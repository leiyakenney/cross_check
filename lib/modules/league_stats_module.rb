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

  def away_team_goals
    away_team_goals = Hash.new(0)
    @games.each do |game|
      away_team_goals[game.away_team_id] += game.away_goals
    end
    away_team_goals
  end

  def games_played
    games_played_data = Hash.new(0)
    @games.each do |game|
      games_played_data[game.home_team_id] += 1
    end
    games_played_data
  end

  def away_games_played
    away_games_played = Hash.new(0)
    @games.each do |game|
      away_games_played[game.away_team_id] += 1
    end
    away_games_played
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

  def highest_scoring_away_team
    highest_away = away_team_goals.max_by do |id, goals|
      (goals.to_f / away_games_played[id])
    end
    convert_id_to_name(highest_away[0])
  end

  def lowest_scoring_away_team
    lowest_away = away_team_goals.min_by do |id, goals|
      (goals.to_f / away_games_played[id])
    end
    convert_id_to_name(lowest_away[0])
  end

end
