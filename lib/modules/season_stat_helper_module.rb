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

   def most_hits(season)

   end

end
