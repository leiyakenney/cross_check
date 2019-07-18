require 'pry'
module GameStats

  def highest_total_score
    game = @games.max_by {|game| (game.away_goals + game.home_goals)}
    game.away_goals + game.home_goals
  end

  def lowest_total_score
    game = @games.min_by {|game| (game.away_goals + game.home_goals)}
    game.away_goals + game.home_goals
  end

  def biggest_blowout
    game = @games.max_by {|game| (game.away_goals - game.home_goals).abs}
    (game.away_goals - game.home_goals).abs
  end

  def percentage_home_wins
    game_wins = @games.find_all {|game| game.outcome.include?('home win')}
    (game_wins.length / @games.length.to_f).round(2)
  end

  def percentage_visitor_wins
    game_wins = @games.find_all {|game| game.outcome.include?('away win')}
    (game_wins.length / @games.length.to_f).round(2)
  end

  def count_of_games_by_season
    season_hash = Hash.new(0)
    @games.each do |game|
      season_hash[game.season] += 1
    end
    season_hash
  end

  def average_goals_per_game
    total_goals = @games.sum {|game| game.home_goals.to_f + game.away_goals.to_f}
    (total_goals / @games.length).round(2)
  end

  def average_goals_by_season
    season_hash = Hash.new(0)
    @games.each do |game|
      season_hash[game.season] += (game.home_goals.to_f + game.away_goals.to_f)
    end
    avg_hash = {}
    count_of_games_by_season.map do |game_season, sum_of_games|
      avg_hash[game_season] = (season_hash[game_season] / sum_of_games).round(2)
    end
    avg_hash
  end

  def convert_id_to_name(id)
    team = @teams.find {|team| team.team_id == id}
    team.team_name
  end

  def offense_helper
    total_goal_by_team = Hash.new(0)
    @game_teams.each do |game|
      total_goal_by_team[game.team_id] += game.goals.to_f
    end
    total_goal_by_team

     total_games_by_teams = Hash.new(0)
     @game_teams.each do |game|
      total_games_by_teams[game.team_id] += 1
    end
    total_games_by_teams

    avg_offense = Hash.new
    total_goal_by_team.map do |team_id, total_goals|
      avg_offense[team_id] = (total_goal_by_team[team_id]/total_games_by_teams[team_id]).round(2)
    end
    avg_offense
  end

  def best_offense
    avg_offense = offense_helper
    best_offense_team = avg_offense.max_by {|team_id, avg_goals| avg_goals}

    convert_id_to_name(best_offense_team[0])
  end

  def worst_offense
    avg_offense = offense_helper
    best_offense_team = avg_offense.min_by {|team_id, avg_goals| avg_goals}

    convert_id_to_name(best_offense_team[0])
  end
end
