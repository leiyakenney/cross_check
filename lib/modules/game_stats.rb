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

  def best_defense

    #@games.group_by {|k,v| v.away_goals}

    # transformed_hash = @games.group_by { |x| x.away_goals }
  # .map { |k, v| [k, v.group_by{ |x| x.away_goals }] }
  # .to_h
    # #group_by check out tomorr
    total_away_goals_by_home_team = Hash.new(0)

    @games.each do |game|
      total_away_goals_by_home_team[game.home_team_id] += game.away_goals.to_f
    end

    total_away_goals_by_home_team

    # total_games_by_home_teams = Hash.new(0)
    #   #{home_team_id : 21}
    # @games.each do |game|
    #   total_games_by_home_teams[game.home_team_id] += 1
    # end
    #
    # avg_hash = {}
    #
    # total_away_goals_by_home_team.map do |home_team_id, sum_of_away_goals|
    #   avg_hash[home_team_id] = (total_away_goals_by_home_team[home_team_id] / sum_of_away_goals).round(2)
    # end
    #
    # best_defense_id = avg_hash.max_by{|k,v| v}

    # team_name = convert_id_to_name(best_defense_id)
  end

  # def best_defense_2
  #   #group_by check out tomorrow
  #   #group by team id
  #   #max
  #
  #   @games.group_by(& :home_team_id).
  #   end
  # end
end
