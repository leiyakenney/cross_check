require 'pry'
module LeagueStats

  def convert_id_to_name(id)
    team = @teams.find {|team| team.team_id == id}
    team.team_name
  end

  def home_team_goals
    goals_home_team = Hash.new(0)
    @games.each do |game|
      goals_home_team[game.home_team_id] += game.home_goals
    end
    goals_home_team
  end

  def away_team_goals
    goals_away_team = Hash.new(0)
    @games.each do |game|
      goals_away_team[game.away_team_id] += game.away_goals
    end
    goals_away_team
  end

  def home_games_played
    games_home_played = Hash.new(0)
    @games.each do |game|
      games_home_played[game.home_team_id] += 1
    end
    games_home_played
  end

  def away_games_played
    games_away_played = Hash.new(0)
    @games.each do |game|
      games_away_played[game.away_team_id] += 1
    end
    games_away_played
  end

  def total_games_played
    total_games_played = away_games_played.merge!(home_games_played) do |id, ag, hg|
      ag + hg
    end
  end

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


  def total_goals_by_game_team
    total_goal_by_team = Hash.new(0)
    @game_teams.each do |game|
      total_goal_by_team[game.team_id] += game.goals.to_f
    end
    total_goal_by_team
  end

  def total_games_by_game_team
     total_games_by_teams = Hash.new(0)
     @game_teams.each do |game|
      total_games_by_teams[game.team_id] += 1
    end
    total_games_by_teams
  end

  def average_offense
    avg_offense = Hash.new
    total_goals_by_game_team.map do |team_id, total_goals|
      avg_offense[team_id] = (total_goals_by_game_team[team_id]/total_games_by_game_team[team_id]).round(2)
    end
    avg_offense
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

  def home_team_goals_against
    goals_against_home_team = Hash.new(0)
    @games.each do |game|
      goals_against_home_team[game.home_team_id] += game.away_goals
    end
    goals_against_home_team
  end

  def away_team_goals_against
    goals_against_away_team = Hash.new(0)
    @games.each do |game|
      goals_against_away_team[game.away_team_id] += game.home_goals
    end
    goals_against_away_team
  end

  def total_goals_against
    total_goals_against = away_team_goals_against.merge!(home_team_goals_against) do |id, aga, hga|
      aga + hga
    end
    total_goals_against
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

  def games_won_game_team
    game_team_wins = Hash.new(0)
    @game_teams.find_all do |game|
      if game.won == 'TRUE'
        game_team_wins[game.team_id] += 1
      end
    end
    game_team_wins
  end

  def winningest_team
    awesomest_team = games_won_game_team.max_by {|team_id, games_won| games_won.to_f / total_games_by_game_team[team_id]}
    convert_id_to_name(awesomest_team[0])
  end

  def best_fans

    #total home games won using game_teams CSV
    home_game_team_wins = Hash.new(0)
    @game_teams.find_all do |game|
      if game.won == 'TRUE' && game.hoa == 'home'
        home_game_team_wins[game.team_id] += 1
      end
    end
    home_game_team_wins

    #total away games won using game_teams CSV
    away_game_team_wins = Hash.new(0)
    @game_teams.find_all do |game|
      if game.won == 'TRUE' && game.hoa == 'away'
        away_game_team_wins[game.team_id] += 1
      end
    end
    away_game_team_wins

    #total home games played using game_teams CSV
    #note : there is already total_home_games method, but it uses the game CSV
    total_home_games_played = Hash.new(0)
    @game_teams.each do |game|
      if game.hoa == 'home'
        total_home_games_played[game.team_id] += 1
      end
    end
    total_home_games_played

    #total away games played using game_teams CSV
    #note : there is already total_home_games method, but it uses the game CSV
    total_away_games_played = Hash.new(0)
    @game_teams.each do |game|
      if game.hoa == 'away'
        total_away_games_played[game.team_id] += 1
      end
    end
    total_away_games_played

    #percent of home game won using game_team CSV
    percent_of_home_games_won = Hash.new(0)
    home_game_team_wins.map do |team_id, home_wins|
      percent_of_home_games_won[team_id] = home_wins/total_home_games_played[team_id].to_f
    end
    percent_of_home_games_won

    #percent of away game won using game_team CSV
    percent_of_away_games_won = Hash.new(0)
    away_game_team_wins.map do |team_id, away_wins|
      percent_of_away_games_won[team_id] = away_wins/total_away_games_played[team_id].to_f
    end
    percent_of_away_games_won

    #difference between percent home wins & percent away wins
    difference_home_vs_away_won = Hash.new(0)
    percent_of_home_games_won.map do |team_id, home_win|
      difference_home_vs_away_won[team_id] = home_win - percent_of_away_games_won[team_id]
    end
    difference_home_vs_away_won

    #team with greatest difference between home wins vs away wins, return team_id
    team_diff_greatest_home_v_away = difference_home_vs_away_won.max_by {|team_id, diff_avg| diff_avg }

    #convert team id to team name
    convert_id_to_name(team_diff_greatest_home_v_away[0])
  end
end
