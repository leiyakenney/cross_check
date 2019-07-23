module LeagueStats

  def high_low_scoring_home_team
    high_team = home_away_team_goals[:hg].minmax_by do |team, goals|
      (goals.to_f / home_away_games_played[:hg][team])
    end
  end

  def highest_scoring_home_team
    convert_id_to_name(high_low_scoring_home_team[1][0])
  end

  def lowest_scoring_home_team
    convert_id_to_name(high_low_scoring_home_team[0][0])
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
    best_offense_team = avg_offense.minmax_by {|team_id, avg_goals| avg_goals}
  end

  def best_offense
    convert_id_to_name(best_worst_offense[1][0])
  end
  #
  def worst_offense
    convert_id_to_name(best_worst_offense[0][0])
  end

  def best_worst_defense
    top_defense = tot_goals_against.minmax_by do |team_id, goals|
      (goals.to_f/ total_games_played[team_id])
    end
  end

  def best_defense
    convert_id_to_name(best_worst_defense[0][0])
  end

  def worst_defense
    convert_id_to_name(best_worst_defense[1][0])
  end

  def winningest_team
    awesomest_team = games_won_game_team.max_by do |team_id, games_won|
      games_won.to_f / total_games_played[team_id]
    end
    convert_id_to_name(awesomest_team[0])
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
