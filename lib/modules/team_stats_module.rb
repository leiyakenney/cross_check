module TeamStats

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

  #finds the avg percent win for a team by season
  def avg_win_percent_by_season(team_id)
    number_game_by_season = num_games_by_season(team_id)

    avg_win_percent_by_season = Hash.new(0)
      team_wins_by_season(team_id).map do |season, num_season_wins|
      avg_win_percent_by_season[season] = num_season_wins/number_game_by_season[season].to_f
    end
    avg_win_percent_by_season
  end

  #finds best season by finding highest avg and returning season
  def best_worst_season(team_id)
    avg_win_percent_by_season = avg_win_percent_by_season(team_id).minmax_by {|season, avg_win| avg_win}
    avg_win_percent_by_season
  end

  def best_season(team_id)
    best_worst_season(team_id)[1][0].to_i
  end

  def worst_season(team_id)
    best_worst_season(team_id)[0][0].to_i
  end

  #finds worst season by finding lowest avg and returning season
  # def worst_season(team_id)
  #   avg_win_percent_by_season = avg_win_percent_by_season(team_id).min_by {|season, avg_win| avg_win}
  #   avg_win_percent_by_season[0].to_i
  # end


  #Fiddling around with avg_percent_wins by season for team
  #Might be wrong... taking average of season average.
  # def average_win_percentage(team_id)
  #   avg_win_percent_by_season = avg_win_percent_by_season(team_id)
  #
  #   avg_wins_array = []
  #     avg_win_percent_by_season.map do |season, avg_wins|
  #       avg_wins_array << avg_wins
  #     end
  #
  #   avg_wins_array
  #   avg_percent_wins = (avg_wins_array.sum/avg_wins_array.size).round(2)
  # end
end
