module TeamStats

  #BEST/WORST SEASON
  #find the total number of wins for a team by season
  def team_wins_by_season(team_id)

    team_wins_by_season = Hash.new(0)
    @games.map do |game|
      if team_id == game.away_team_id && (game.away_goals > game.home_goals)
        team_wins_by_season[game.season] += 1
      elsif team_id == game.home_team_id && (game.home_goals > game.away_goals)
        team_wins_by_season[game.season] += 1
      else
        team_wins_by_season[game.season] += 0
      end
    end
    team_wins_by_season
  end

  # BEST/WORST SEASON
  #find the total number of games played for a team by season
  def num_games_by_season(team_id)
    num_games_by_season = Hash.new(0)
    @games.map do |game|
      if team_id == game.home_team_id || team_id == game.away_team_id
        num_games_by_season[game.season] += 1
      end
    end
    num_games_by_season
  end

  # BEST/WORST SEASON
  #finds the avg percent win for a team by season
  def avg_win_percent_by_season(team_id)
    number_game_by_season = num_games_by_season(team_id)

    avg_win_percent_by_season = Hash.new(0)
      team_wins_by_season(team_id).map do |season, num_season_wins|
      avg_win_percent_by_season[season] = num_season_wins/number_game_by_season[season].to_f
    end
    avg_win_percent_by_season
  end

  # BEST/WORST SEASON
  #finds best season by finding highest avg and returning season
  def best_worst_season(team_id)
    avg_win_percent_by_season = avg_win_percent_by_season(team_id).minmax_by {|season, avg_win| avg_win}
    avg_win_percent_by_season
  end

  # BEST/WORST SEASON
  def best_season(team_id)
    best_worst_season(team_id)[1][0].to_i
  end

  # BEST/WORST SEASON
  def worst_season(team_id)
    best_worst_season(team_id)[0][0].to_i
  end

  def average_win_percentage(team_id)
    #{3=>10.0, 6=>28.0, 5=>2.0, 17=>1.0}
  average_win_by_team = games_won_game_team[team_id]/total_games_by_game_team[team_id].to_f
  average_win_by_team.round(2)
  end
end
