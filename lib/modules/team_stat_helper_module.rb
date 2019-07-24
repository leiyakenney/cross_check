require 'pry'
module TeamStatHelpers





  #========= SEASONAL SUMMARY HELPER START =============
  def win_percentage(games, team_id)
    return 0.0 if games.empty?
    num_won = 0
    games.each do |game|
      if (team_id == game.home_team_id && game.home_goals > game.away_goals) ||
      (team_id == game.away_team_id && game.home_goals < game.away_goals)
        num_won += 1
      end
    end

    unless games.count == 0.0
      percent_won = (num_won/games.count.to_f).round(2)
    end
  end

  def total_goals_scored(games, team_id)
    return 0 if games.empty?
    num_goals = 0
    games.each do |game|
      if team_id == game.home_team_id
        num_goals += game.home_goals
      elsif team_id == game.away_team_id
        num_goals += game.away_goals
      end
    end
    num_goals
  end

  def total_goals_against(games, team_id)
    return 0 if games.empty?
    num_goals_against = 0
    games.each do |game|
      if team_id == game.home_team_id
        num_goals_against += game.away_goals
      elsif team_id == game.away_team_id
        num_goals_against += game.home_goals
      end
    end
    num_goals_against.round
  end

  def average_goals_scored(games, team_id)
    return 0.0 if games.empty?
    total_scored = total_goals_scored(games, team_id).to_f
    avg_goals = (total_scored/games.count)
    avg_goals.round(2)
  end

  def average_goals_against(games, team_id)
    return 0.0 if games.empty?
    total_against = total_goals_against(games, team_id)
    avg_against = (total_against.to_f/games.count)
    avg_against.round(2)
  end

  def collect_games_by_season(team_id)
    @games.each_with_object(Hash.new) do |game, hash|
      if game.home_team_id == team_id || game.away_team_id == team_id
        if hash[game.season].nil?
          hash[game.season] = [game]
        else
          hash[game.season] << game
        end
      end
    end
  end

  def reg_vs_post(team_id)
    games_by_season = collect_games_by_season(team_id)
    games_by_season.transform_values do |games|
      games.group_by do |game|
        type_to_season(game.type)
      end
    end
  end

  def add_nil_post_regular_season(team_id)
    season_post_reg_hash = reg_vs_post(team_id)
    postseason = {:postseason => []}
    season_post_reg_hash.map do |season, values|
      if values.none? {|value| value.include? :postseason }
        season_post_reg_hash[season].merge!(postseason)
      end
    end
    season_post_reg_hash
  end

  def type_to_season(type)
    if type == 'P'
      return :postseason
    elsif type == 'R'
      return :regular_season
    end
  end
end
