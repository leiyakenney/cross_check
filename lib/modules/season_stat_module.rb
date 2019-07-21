module SeasonStat
#OLD - using arrays to return game_ids in season
#finds all game_ids within a given season
 # def game_id_in_season(season)
 #   game_id_in_season = []
 #
 #     @games.each do |game|
 #       if game.season == season
 #         game_id_in_season << game.game_id
 #       end
 #     end
 #  game_id_in_season
 #  end

 #Hash with season as key and value(s) as game_ids
 def game_id_in_season
    game_id_by_season = Hash.new { |game_id_by_season, season| game_id_by_season[season] = [] }

    @games.map do |game|
      game_id_by_season[game.season].push(game.game_id)
    end
    game_id_by_season
 end

  #finds the total shots for each team within a given season
  def total_shots_by_season(season)


    total_shots_by_season = Hash.new(0)
    @game_teams.map do |game|
      if game_id_in_season[season].any? game.game_id
        total_shots_by_season[game.team_id] += game.shots
      end
    end
    total_shots_by_season
  end

  #finds the total goals for each team within a given season
  def total_goals_by_season(season)
    game_id_in_season = game_id_in_season(season)

    total_goals_by_season = Hash.new(0)
    @game_teams.map do |game|

      if game_id_in_season.any? game.game_id
        total_goals_by_season[game.team_id] += game.goals
      end
    end
    total_goals_by_season
  end

  #finds the shot to goal ratio for all teams within a given season
  def shot_ratio_by_season(season)

    shot_ratio_by_season = Hash.new
    total_shots_by_season(season).map do |team_id, total_shots|
      shot_ratio_by_season[team_id] = total_shots/total_goals_by_season(season)[team_id].to_f
    end
    shot_ratio_by_season
  end

  #finds min and max teams by shot-goal ratio within a given season
  def minmax_shot_ratio_by_season(season)
    shot_ratio_by_season(season).minmax_by {|team_id, shot_ratio| shot_ratio}
  end

  #finds team with lowest shot-goal ratio within a given season
  def most_accurate_team(season)
    convert_id_to_name(minmax_shot_ratio_by_season(season)[0][0])
  end

  #finds team with highest shot-goal ratio within a given season
  def least_accurate_team(season)
    convert_id_to_name(minmax_shot_ratio_by_season(season)[1][0])
  end
end
