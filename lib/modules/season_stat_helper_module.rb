module SeasonStatHelper

  def games_in_season(season)
    games_in_season_id = @games.find_all do |game|
      game.season == season
    end
    games_in_season_id.map do |game_id|
      game_id.game_id
    end
  end

  def game_teams_in_season(season)
    teams_in_season = @game_teams.find_all do |game_team|
      games_in_season(season).include?(game_team.game_id)
    end
  end

  def total_hits(season)
    total_hits_hash = Hash.new(0)
    game_teams_in_season(season).each do |game_team|
      total_hits_hash[game_team.team_id] += game_team.hits
    end
    total_hits_hash
  end

  def minmax_hits(season)
      total_hits(season).minmax_by {|team_id, hits| hits}
  end

end
