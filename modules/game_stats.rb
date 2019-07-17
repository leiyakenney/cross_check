require 'pry'
module GameStats

  def highest_total_score
    @games.max_by {|game| (game.away_goals.to_i + game.home_goals.to_i)}
  end

  def lowest_total_score
    @games.min_by {|game| (game.away_goals.to_i + game.home_goals.to_i)}
  end

  def biggest_blowout
    @games.max_by {|game| game.away_goals.to_i - game.home_goals.to_i}
  end

  def percentage_home_wins(team_id)
    game_collection = @games.find_all {|game| game.home_team_id == team_id}
    game_wins = game_collection.find_all {|game| game.outcome.include?('home win')}
    ((game_wins.count / game_collection.count.to_f) * 100).round(2)
  end

  def percentage_visitor_wins(team_id)
    game_collection = @games.find_all {|game| game.away_team_id == team_id}
    game_wins = game_collection.find_all {|game| game.outcome.include?('away win')}
    ((game_wins.count / game_collection.count.to_f) * 100).round(2)
  end

  def count_of_games_by_season(season_id)
    season_hash = {}
    season_games = @games.find_all {|game| game.season == season_id}
    season_hash[season_id] = season_games.count
    season_hash
  end

  def average_goals_per_game
    total_goals = @games.sum {|game| game.home_goals.to_f + game.away_goals.to_f}
    (total_goals / @games.count).round(2)
  end

  def average_goals_by_season(season_id)
    season_hash = {}
    season_games = @games.find_all {|game| game.season == season_id}
    total_goals = season_games.sum {|game| game.home_goals.to_f + game.away_goals.to_f}
    season_hash[season_id] = (total_goals / @games.count).round(2)
    season_hash
  end
end
