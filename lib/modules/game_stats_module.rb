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
    avg_hash = {}
    @games.each do |game|
      season_hash[game.season] += (game.home_goals.to_f + game.away_goals.to_f)
    end
    count_of_games_by_season.map do |game_season, sum_of_games|
      avg_hash[game_season] = (season_hash[game_season] / sum_of_games).round(2)
    end
    avg_hash
  end
end
