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

  def percentage_home_wins
    game_wins = @games.find_all {|game| game.outcome.include?('home win')}
    (game_wins.length / @games.length.to_f).round(2)
  end

  def total_home_wins_by_team
    home_wins = Hash.new(0)
    @game_teams.each do |team|
      if team.won && team.hoa == 'home'
        home_wins[team.team_id] += 1
      end
    end
    home_wins
  end

  def home_wins_percentage_by_team
    win_percentages = total_home_wins_by_team.merge(total_games_by_game_team){|team, win, games| win/games.to_f}
    max = win_percentages.max_by{|k,v| v}
    max[1].round(2)
  end

  def total_away_wins_by_team
    away_wins = Hash.new(0)
    @game_teams.each do |team|
      if team.won && team.hoa == 'away'
        away_wins[team.team_id] += 1
      end
    end
    away_wins
  end

  def away_wins_percentage_by_team
    aw_percentages = total_away_wins_by_team.merge(total_games_by_game_team){|team, win, games| win/games.to_f}
    max = aw_percentages.max_by{|k,v| v}
    max[1].round(2)
  end

  # away_wins_percentage_by_team = Hash.new(0)
  # total_away_wins_by_team.map do |team_id, away_wins|
  #   away_wins_percentage_by_team[team_id] = away_wins/total_away_games_played[team_id].to_f
  # end
  # away_wins_percentage_by_team

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

  def total_home_games_by_team
    total_home_games_played = Hash.new(0)
    @game_teams.each do |game|
      if game.hoa == 'home'
        total_home_games_played[game.team_id] += 1
      end
    end
    total_home_games_played
  end

  def total_away_games_by_team
    total_away_games_played = Hash.new(0)
    @game_teams.each do |game|
      if game.hoa == 'away'
        total_away_games_played[game.team_id] += 1
      end
    end
    total_away_games_played
  end

  def percent_home_games_won
    percent_of_home_games_won = Hash.new(0)
    total_home_wins_by_team.map do |team_id, home_wins|
      percent_of_home_games_won[team_id] = home_wins/total_home_games_by_team[team_id].to_f
    end
    percent_of_home_games_won
  end

  def diff_home_vs_away
    difference_home_vs_away_won = Hash.new(0)
    percent_home_games_won.map do |team_id, home_win|
      difference_home_vs_away_won[team_id] = home_win - away_wins_percentage_by_team
    end
    difference_home_vs_away_won
  end

  def best_fans
    team_diff_greatest_home_v_away = diff_home_vs_away.max_by {|team_id, diff_win| diff_win }
    convert_id_to_name(team_diff_greatest_home_v_away[0])
  end
end
