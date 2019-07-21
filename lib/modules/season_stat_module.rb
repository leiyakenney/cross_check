module SeasonStat

 def game_id_in_season(season)
   game_id_in_season = []

     @games.each do |game|
       if game.season == season
         game_id_in_season << game_id
       end
     end
  game_id_in_season
  end
end
