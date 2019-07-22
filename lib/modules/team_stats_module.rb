module TeamStats

  def team_info(team_id)
    info_hash = {}
    find_team = @teams.find {|team| team.team_id == team_id}
    find_team.instance_variables.each do |variable|
      info_hash[variable.to_s.delete("@")] = find_team.instance_variable_get(variable).to_s
    end
  info_hash
  end

  def favorite_opponent(team_id)
    best_opponent = games_played_vs_opponent_percentage(team_id).max_by {|id, pw| pw}
    convert_id_to_name(best_opponent[0])
  end

  def most_goals_scored(id)
    team_games = @game_teams.find_all do |game|
       game.team_id == id
     end
    high_game = team_games.max_by {|game| game.goals}
    high_game.goals
  end

  def fewest_goals_scored(id)
    team_games = @game_teams.find_all do |game|
       game.team_id == id
     end
    low_game = team_games.min_by {|game| game.goals}
    low_game.goals
  end

  def biggest_team_blowout(team_id)
    blowout_amt = 0
    @games.each do |game|
      if game.home_team_id == team_id && game.outcome.include?('home win') || game.away_team_id == team_id && game.outcome.include?('away win')
        goal_diff = (game.home_goals - game.away_goals).abs
        if goal_diff > blowout_amt
          blowout_amt = goal_diff
        end
      end
    end
    blowout_amt
  end

  def worst_loss(team_id)
    loss_amt = 0
    @games.each do |game|
      if game.home_team_id == team_id && game.outcome.include?('away win') || game.away_team_id == team_id && game.outcome.include?('home win')
        goal_diff = (game.home_goals - game.away_goals).abs
        if goal_diff > loss_amt
          loss_amt = goal_diff
        end
      end
    end
    loss_amt
  end

  def rival(team_id)
    worst_opponent = games_played_vs_opponent_percentage(team_id).min_by {|id, pw| pw}
    convert_id_to_name(worst_opponent[0])
  end

  def head_to_head(team_id)
    names_vs_percentage = {}
    games_played_vs_opponent_percentage(team_id).each do |id, percentage|
      names_vs_percentage[convert_id_to_name(id)] = percentage.round(2)
    end
    names_vs_percentage
  end

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
    number_game_by_season = num_games_by_season(team_id)
    avg_win_percent_by_season = Hash.new(0)
    team_wins_by_season(team_id).map do |season, num_season_wins|
      avg_win_percent_by_season[season] = num_season_wins/number_game_by_season[season].to_f
    end
    avg_win_percent_by_season
  end

  def best_worst_season(team_id)
    avg_win_percent_by_season = avg_win_percent_by_season(team_id).minmax_by {|season, avg_win| avg_win}
    avg_win_percent_by_season
  end

  def best_season(team_id)
    best_worst_season(team_id)[1][0]
  end

  def worst_season(team_id)
    best_worst_season(team_id)[0][0]
  end

  def average_win_percentage(team_id)
    average_win_by_team = games_won_game_team[team_id]/total_games_by_game_team[team_id].to_f
    average_win_by_team.round(2)
  end

  def seasonal_summary(team_id)
    season_summary_of_games = add_nil_post_regular_season(team_id)
    summary_hash = Hash.new
    season_summary_of_games.map do |season, sub_hash|
      summary_hash[season] = sub_hash.transform_values do |games|
        {:win_percentage => win_percentage(games, team_id),
        :total_goals_scored => total_goals_scored(games, team_id),
        :total_goals_against => total_goals_against(games, team_id),
        :average_goals_scored => average_goals_scored(games, team_id),
        :average_goals_against => average_goals_against(games, team_id)}
      end
    end
    #sorts to postseason first, needs to sort to regularseason
    #postseason first
    test = summary_hash.transform_values { |v| v.sort.to_h}
    #optional?????

    #regularseason first
    #summary_hash.transform_values { |v| v.sort { |k, v| v <=> k }.to_h}
    test
    #from stackover flow https://stackoverflow.com/users/2035262/aleksei-matiushkin
  end
end
