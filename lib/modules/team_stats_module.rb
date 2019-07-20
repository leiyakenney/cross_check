module TeamStats


  def team_wins_by_season(team_id)

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


  def num_games_by_season(team_id)
    num_games_by_season = Hash.new(0)
    @games.map do |game|
      if team_id == game.home_team_id || team_id == game.away_team_id
        num_games_by_season[game.season] += 1
      end
    end
    num_games_by_season
  end

  def avg_win_percent_by_season(team_id)

    avg_win_percent_by_season = Hash.new(0)

    team_wins_by_season(team_id).map do |wins|

  end
end
