module SeasonStatHelper

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
    games_won_regular_season(season_id).each do |id, gw|
      win_percentage[id] = (gw / games_played_regular_season(season_id)[id].to_f).round(2)
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
    games_won_post_season(season_id).each do |id, pg|
      win_percentage[id] = (pg / games_played_post_season(season_id)[id].to_f).round(2)
    end
    win_percentage
  end
end
