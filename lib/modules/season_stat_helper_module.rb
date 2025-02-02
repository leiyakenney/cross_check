module SeasonStatHelper

  def games_in_season(season)
    games_in_season_id = {}
    @games.each do |game|
      if game.season == season
        games_in_season_id[game.game_id] = game.date_time
      end
    end
    games_in_season_id
  end

  def total_hits(season)
    season_games = games_in_season(season)
    total_hits = Hash.new(0)
    @game_teams.each do |game|
      if season_games.keys.include?(game.game_id)
        total_hits[game.team_id] += game.hits
      end
    end
    total_hits
  end

  def minmax_hits(season)
      hit_total = total_hits(season)
      hit_total.minmax_by {|team_id, hits| hits}
  end

  def games_played_regular_season(season_id)
    games_played = Hash.new(0)
    @games.each do |game|
      if game.season == season_id && game.type == "R"
          games_played[game.home_team_id] += 1
          games_played[game.away_team_id] += 1
      end
    end
    games_played
  end

  def games_won_regular_season(season_id)
    games_won = Hash.new(0)
    @games.each do |game|
      if game.season == season_id && game.type == "R"
        if game.outcome.include?('home')
          games_won[game.home_team_id] += 1
        elsif game.outcome.include?('away')
          games_won[game.away_team_id] += 1
        end
      end
    end
    games_won
  end

  def win_percentage_regular_season(season_id)
    win_percentage = {}
    games_played_regular_season(season_id).each do |id, gw|
      if games_won_regular_season(season_id).has_key?(id)
        win_percentage[id] = (games_won_regular_season(season_id)[id].to_f / gw).round(2)
      else
        win_percentage[id] = 0
      end
    end
    win_percentage
  end

  def games_played_post_season(season_id)
    games_played = Hash.new(0)
    @games.each do |game|
      if game.season == season_id && game.type == "P"
          games_played[game.home_team_id] += 1
          games_played[game.away_team_id] += 1
      end
    end
    games_played
  end

  def games_won_post_season(season_id)
    games_won = Hash.new(0)
    @games.each do |game|
      if game.season == season_id && game.type == "P"
        if game.outcome.include?('home')
          games_won[game.home_team_id] += 1
        elsif game.outcome.include?('away')
          games_won[game.away_team_id] += 1
        end
      end
    end
    games_won
  end

  def win_percentage_post_season(season_id)
    win_percentage = {}
    games_played_post_season(season_id).each do |id, pg|
      if games_won_post_season(season_id).has_key?(id)
        win_percentage[id] = (games_won_post_season(season_id)[id].to_f / pg).round(2)
      else
        win_percentage[id] = 0
      end
    end
    win_percentage
  end

  def game_teams_in_season(season)
    season_games = games_in_season(season)
    teams_in_season = @game_teams.find_all do |game_team|
      season_games.include?(game_team.game_id)
    end
  end

  def ppg_goals(season)
    ppg_hash = Hash.new(0)
    game_teams_in_season(season).each do |game|
      ppg_hash[game.team_id] += game.ppg
    end
    ppg_hash
  end
end
