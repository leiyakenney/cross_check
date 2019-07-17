require 'pry'
module GameStats

  def highest_total_score
    @games.max_by {|game| (game.data['away_goals'].to_i + game.data['home_goals'].to_i)}
  end

  def lowest_total_score
    @games.min_by {|game| (game.data['away_goals'].to_i + game.data['home_goals'].to_i)}
  end

  def biggest_blowout
    @games.max_by {|game| game.data['away_goals'].to_i - game.data['home_goals'].to_i}
  end

  def percentage_home_wins(team_id)
    game_collection = @games.find_all {|game| game.data['home_team_id'] == team_id}
    game_wins = game_collection.find_all {|game| game.data['outcome'].include?('win')}
    ((game_collection.count.to_f / game_wins.count) * 100).round(2)
  end

end
