module SeasonStatHelper

  def game_id_in_season(season)
    game_id_in_season = []

      @games.each do |game|
        if game.season == season
          game_id_in_season << game.game_id
        end
      end
   game_id_in_season
   end

  def total_hits
    hits_hash = {}
    @game_teams.each do |team|
      if game_id_in_season(season).include?(game_id)
        @game_teams.find_all do |game|
          hits_hash[game.season_id] = team.hits_hash
        end 
      end
    end
  end

   def teams_and_hits
     hit_hash = {}
      hit_hash[game_team.team_id] = total_hits
   end

   def most_hits(season)
   end

end
