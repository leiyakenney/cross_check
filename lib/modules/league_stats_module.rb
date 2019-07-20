module LeagueStats

  def highest_scoring_home_team
    high_team = home_team_goals.max_by do |team, goals|
      (goals.to_f / home_games_played[team])
    end
    convert_id_to_name(high_team[0])
  end

  def lowest_scoring_home_team
    low_team = home_team_goals.min_by do |team, goals|
      (goals.to_f / home_games_played[team])
    end
    convert_id_to_name(low_team[0])
  end

  def highest_scoring_visitor
    away_high = away_team_goals.max_by do |id, goals|
      (goals.to_f / away_games_played[id])
    end
    convert_id_to_name(away_high[0])
  end

  def lowest_scoring_visitor
    away_low = away_team_goals.min_by do |id, goals|
      (goals.to_f / away_games_played[id])
    end
    convert_id_to_name(away_low[0])
  end

  def count_of_teams
    @teams.count {|team| team.team_id}
  end

  def best_offense
    avg_offense = average_offense
    best_offense_team = avg_offense.max_by {|team_id, avg_goals| avg_goals}
    convert_id_to_name(best_offense_team[0])
  end

  def worst_offense
    avg_offense = average_offense
    best_offense_team = avg_offense.min_by {|team_id, avg_goals| avg_goals}
    convert_id_to_name(best_offense_team[0])
  end

  def best_defense
    top_defense = total_goals_against.min_by do |team_id, goals|
      (goals.to_f/ total_games_played[team_id])
    end
    convert_id_to_name(top_defense[0])
  end

  def worst_defense
    lowest_defense = total_goals_against.max_by do |team_id, goals|
      (goals.to_f/ total_games_played[team_id])
    end
    convert_id_to_name(lowest_defense[0])
  end

  def winningest_team
    awesomest_team = games_won_game_team.max_by do |team_id, games_won|
      games_won.to_f / total_games_by_game_team[team_id]
    end
    convert_id_to_name(awesomest_team[0])
  end

  def percentage_home_wins
    game_wins = @games.find_all {|game| game.outcome.include?('home win')}
    (game_wins.length / @games.length.to_f).round(2)
  end

  def worst_fans
    worst_fans_arr = []
    @game_teams.each do |team|
      if away_wins_percentage_by_team > home_wins_percentage_by_team
        worst_fans_arr << team.team_id
      end
    end
    worst_fans_arr.uniq.map do |worst|
      convert_id_to_name(worst)
    end
  end

  def best_fans
    team_diff_greatest_home_v_away = difference_home_vs_away_won.max_by {|team_id, diff_win| diff_win }
    convert_id_to_name(team_diff_greatest_home_v_away[0])
  end
end
