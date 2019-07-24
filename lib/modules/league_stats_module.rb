module LeagueStats

  def convert_id_to_name(id)
    team = @teams.find {|team| team.team_id == id}
    team.team_name
  end

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
    homeaway_team_goals = home_away_team_goals
    homeaway_games_played = home_away_games_played
    away_high = homeaway_team_goals[:ag].minmax_by do |id, goals|
      (goals.to_f / homeaway_games_played[:ag][id])
    end
  end

  def highest_scoring_visitor
    highlow_scoring_visitor = high_low_scoring_visitor
    convert_id_to_name(highlow_scoring_visitor[1][0])
  end

  def lowest_scoring_visitor
    highlow_scoring_visitor = high_low_scoring_visitor
    convert_id_to_name(highlow_scoring_visitor[0][0])
  end

  def count_of_teams
    @teams.count {|team| team.team_id}
  end

  def total_goals_games_gt
    total_goal_game = {:tgo => Hash.new(0), :tga => Hash.new(0)}
    @game_teams.each do |game|
      total_goal_game[:tgo][game.team_id] += game.goals.to_f
      total_goal_game[:tga][game.team_id] += 1
    end
    total_goal_game
  end

  def average_offense
    tot_goals_games_gt = total_goals_games_gt
    avg_offense = Hash.new
    tot_goals_games_gt[:tgo].each do |team_id, total_goals|
      avg_offense[team_id] =
      (tot_goals_games_gt[:tgo][team_id].to_f/tot_goals_games_gt[:tga][team_id]).round(2)
    end
    avg_offense
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

  def home_away_goals_against
    home_away_against = {:hga => Hash.new(0), :aga => Hash.new(0)}
    @games.each do |game|
      home_away_against[:hga][game.home_team_id] += game.away_goals
      home_away_against[:aga][game.away_team_id] += game.home_goals
    end
    home_away_against
  end

  def tot_goals_against
    homeaway_goals_against = home_away_goals_against
    total_goals_against = {}
    homeaway_goals_against[:hga].each do |id, hga|
      total_goals_against[id] = (hga + homeaway_goals_against[:aga][id])
    end
    total_goals_against
  end

  def total_games_played
    homeaway_games_played = home_away_games_played
    tg = {}
    homeaway_games_played[:hg]
      .each {|id, gp| tg[id] = (gp + homeaway_games_played[:ag][id])}
     tg
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

  def games_won_game_team
    game_team_wins = Hash.new(0)
    @game_teams.each do |game|
      if game.won == 'TRUE'
        game_team_wins[game.team_id] += 1
      end
    end
    game_team_wins
  end

  def winningest_team
    awesomest_team = games_won_game_team
    tot_games_played = total_games_played
    da_best = awesomest_team.max_by do |team_id, games_won|
      games_won.to_f / tot_games_played[team_id]
    end
    convert_id_to_name(da_best[0])
  end

  def home_away_game_team_wins
    home_away_wins = {:hw => Hash.new(0), :aw => Hash.new(0)}
      @game_teams.find_all do |game|
        if game.won == 'TRUE' && game.hoa == 'home'
          home_away_wins[:hw][game.team_id] += 1
        elsif game.won == 'TRUE' && game.hoa == 'away'
          home_away_wins[:aw][game.team_id] += 1
        end
      end
    home_away_wins
  end

  def total_home_away_games_played
    total_home_away = {:hgp => Hash.new(0), :agp => Hash.new(0)}
    @game_teams.each do |game|
      if game.hoa == 'home'
        total_home_away[:hgp][game.team_id] += 1
      else
        total_home_away[:agp][game.team_id] += 1
      end
    end
    total_home_away
  end

  def percent_of_home_games_won
    homeaway_game_team_wins = home_away_game_team_wins
    total_homeaway_games_played = total_home_away_games_played

    percent_of_home_games_won = Hash.new(0)
      homeaway_game_team_wins[:hw].map do |team_id, home_wins|
        percent_of_home_games_won[team_id] =
          home_wins/total_homeaway_games_played[:hgp][team_id].to_f
      end
    percent_of_home_games_won
  end

  def percent_of_away_games_won
    percent_of_away_games_won = Hash.new(0)
      home_away_game_team_wins[:aw].map do |team_id, away_wins|
        percent_of_away_games_won[team_id] =
          away_wins/total_home_away_games_played[:agp][team_id].to_f
    end
    percent_of_away_games_won
  end

  def difference_home_vs_away_won
    home_game_win_percent = percent_of_home_games_won
    away_game_win_percent = percent_of_away_games_won
    difference_home_vs_away_won = Hash.new(0)
    home_game_win_percent.map do |team_id, home_win|
      difference_home_vs_away_won[team_id] = home_win - away_game_win_percent[team_id]
    end
    difference_home_vs_away_won
  end

  def best_fans
    diff_home_vs_away_won = difference_home_vs_away_won
    team_diff_greatest_home_v_away = diff_home_vs_away_won.max_by {|team_id, diff_win| diff_win }
    convert_id_to_name(team_diff_greatest_home_v_away[0])
  end

  def worst_fans
    home_away_difference = difference_home_vs_away_won
    lowest_difference = home_away_difference.find_all do |team_id, diff_win|
      diff_win < 0
    end
    lowest_difference
  end
end
