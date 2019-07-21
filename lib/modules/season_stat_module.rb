module SeasonStat

 def game_id_in_season(season)
   game_id_in_season = []

     @games.each do |game|
       if game.season == season
         game_id_in_season << game.game_id
       end
     end
  game_id_in_season
  end

  def total_shots_by_season(season)
    game_id_in_season = game_id_in_season(season)
    new_hash = Hash.new(0)
    @game_teams.map do |game|
      if game_id_in_season.any? game.game_id
        new_hash[game.team_id] += game.shots
      end
    end
    new_hash
  end

  def total_goals_by_season(season)
    game_id_in_season = game_id_in_season(season)
    new_hash = Hash.new(0)
    @game_teams.map do |game|
      if game_id_in_season.any? game.game_id
        new_hash[game.team_id] += game.goals
      end
    end
    new_hash
  end

  def shot_ratio_by_season(season)
    total_goals_by_season = total_goals_by_season(season)
    total_shots_by_season = total_shots_by_season(season)

    new_hash = Hash.new
    total_shots_by_season.map do |team_id, total_shots|
      new_hash[team_id] = total_shots/total_goals_by_season[team_id].to_f
    end
    new_hash
  end

  def minmax_shot_ratio_by_season(season)
end
