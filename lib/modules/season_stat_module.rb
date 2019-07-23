module SeasonStat

  def most_hits(season)
      convert_id_to_name(minmax_hits(season)[1][0])
  end

  def fewest_hits(season)
      convert_id_to_name(minmax_hits(season)[0][0])
  end

  def surprise_bust_calculator(season_id)
    differential = {}
    win_percentage_post_season(season_id).map do |id, pw|
      differential[id] = (win_percentage_regular_season(season_id)[id] - pw).round(2)
    end
    differential.minmax_by {|id,dif| dif}
  end

  def biggest_bust(season_id)
    convert_id_to_name(surprise_bust_calculator(season_id)[1][0])
  end

  def biggest_surprise(season_id)
    convert_id_to_name(surprise_bust_calculator(season_id)[0][0])
  end

 def game_id_in_season
    game_id_by_season = Hash.new { |game_id_by_season, season| game_id_by_season[season] = [] }
    @games.map do |game|
      game_id_by_season[game.season].push(game.game_id)
    end
    game_id_by_season
 end

 def total_shots_by_season(season)
    game_id_in_season_hash = game_id_in_season
    total_shots_by_season = Hash.new(0)
    @game_teams.map do |game|
      if game_id_in_season_hash[season].include? game.game_id
        total_shots_by_season[game.team_id] += game.shots
      end
    end
    total_shots_by_season
  end

  def total_goals_by_season(season)
    game_id_in_season_hash = game_id_in_season
    total_goals_by_season = Hash.new(0)
    @game_teams.map do |game|
      if game_id_in_season_hash[season].include? game.game_id
        total_goals_by_season[game.team_id] += game.goals
      end
    end
    total_goals_by_season
  end

  def shot_ratio_by_season(season)
    shot_ratio_by_season = Hash.new
    total_shots_by_season(season).map do |team_id, total_shots|
      shot_ratio_by_season[team_id] = total_shots/total_goals_by_season(season)[team_id].to_f
    end
    shot_ratio_by_season
  end

  def minmax_shot_ratio_by_season(season)
    shot_ratio_by_season(season).minmax_by {|team_id, shot_ratio| shot_ratio}
  end

  def most_accurate_team(season)
    convert_id_to_name(minmax_shot_ratio_by_season(season)[0][0])
  end

  def least_accurate_team(season)
    convert_id_to_name(minmax_shot_ratio_by_season(season)[1][0])
  end

  def winningest_coach(season)
    # @game_teams.group_by {|game| game.team_id}.values.map {|games| games.select {|game| game.won == "TRUE"}}
  end
end
