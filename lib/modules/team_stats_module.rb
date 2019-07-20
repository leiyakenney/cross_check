module TeamStats


  def best_season(team_id)

    team_wins_by_season = Hash.new(0)
    @games.map do |game|
      if team_id == game.away_team_id && (game.away_goals > game.home_goals)
        team_wins_by_season[game.season] += 1
      elsif team_id == game.home_team_id && (game.home_goals > game.away_goals)
        team_wins_by_season[game.season] += 1
      else
        team_wins_by_season[game.season] += 0
      end
    end
    team_wins_by_season
  end
end
