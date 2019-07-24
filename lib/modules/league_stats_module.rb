module LeagueStats

  def home_away_team_goals
    goals_home_away = {:hg => Hash.new(0), :ag => Hash.new(0)}
    @games.each do |game|
      goals_home_away[:hg][game.home_team_id] += game.home_goals
      goals_home_away[:ag][game.away_team_id] += game.away_goals
    end
    goals_home_away
  end

  def home_away_games_played
    home_away = {:hg => Hash.new(0), :ag => Hash.new(0)}
    @games.each do |game|
      home_away[:hg][game.home_team_id] += 1
      home_away[:ag][game.away_team_id]+= 1
    end
    home_away
  end

  def high_low_scoring_home_team
    homeaway_games_played = home_away_games_played
    homeaway_team_goals = home_away_team_goals
    high_team = homeaway_team_goals[:hg].minmax_by do |team, goals|
      (goals.to_f / homeaway_games_played[:hg][team])
    end
  end

  def highest_scoring_home_team
    highlow_scoring_home_team = high_low_scoring_home_team
    convert_id_to_name(highlow_scoring_home_team[1][0])
  end

  def lowest_scoring_home_team
    highlow_scoring_home_team = high_low_scoring_home_team
    convert_id_to_name(highlow_scoring_home_team[0][0])
  end

  def high_low_scoring_visitor
    away_high = home_away_team_goals[:ag].minmax_by do |id, goals|
      (goals.to_f / home_away_games_played[:ag][id])
    end
  end

  def highest_scoring_visitor
    convert_id_to_name(high_low_scoring_visitor[1][0])
  end

  def lowest_scoring_visitor
    convert_id_to_name(high_low_scoring_visitor[0][0])
  end

  def count_of_teams
    @teams.count {|team| team.team_id}
  end

  def best_worst_offense
    avg_offense = average_offense
    avg_offense.minmax_by {|team_id, avg_goals| avg_goals}
  end

  def best_offense
    convert_id_to_name(best_worst_offense[1][0])
  end
  #
  def worst_offense
    convert_id_to_name(best_worst_offense[0][0])
  end

  def best_worst_defense
    total_ga = tot_goals_against
    total_games = total_games_played
    top_defense = total_ga.minmax_by do |team_id, goals|
      (goals.to_f/ total_games[team_id])
    end
  end

  def best_defense
    convert_id_to_name(best_worst_defense[0][0])
  end

  def worst_defense
    convert_id_to_name(best_worst_defense[1][0])
  end

  def winningest_team
    awesomest_team = games_won_game_team
    tot_games_played = total_games_played
    da_best = awesomest_team.max_by do |team_id, games_won|
      games_won.to_f / tot_games_played[team_id]
    end
    convert_id_to_name(da_best[0])
  end


  def worst_fans
    home_away_difference = difference_home_vs_away_won
      lowest_difference = home_away_difference.find_all do |team_id, diff_win|
      diff_win < 0
      end
    lowest_difference
  end

  def best_fans
    team_diff_greatest_home_v_away = difference_home_vs_away_won.max_by {|team_id, diff_win| diff_win }
    convert_id_to_name(team_diff_greatest_home_v_away[0])
  end
end
