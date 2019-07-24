module TeamStats

  def team_info(team_id)
    info_hash = {}
    find_team = @teams.find {|team| team.team_id == team_id}
    find_team.instance_variables.each do |variable|
      info_hash[variable.to_s.delete("@")] = find_team.instance_variable_get(variable).to_s
    end
  info_hash
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
    average_win_by_team = games_won_game_team[team_id]/total_games_played[team_id].to_f
    average_win_by_team.round(2)
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

  def games_played_against_opponents(team_id)
    opponent_games_played = Hash.new(0)
    @games.each do |game|
      if game.away_team_id == team_id
        opponent_games_played[game.home_team_id] += 1
      elsif game.home_team_id == team_id
        opponent_games_played[game.away_team_id] += 1
      end
    end
    opponent_games_played
  end

  def games_lost_against_opponents(team_id)
    opponent_games_won = Hash.new(0)
    @games.each do |game|
      if game.away_team_id == team_id && game.outcome.include?('away')
        opponent_games_won[game.home_team_id] += 1
      elsif game.home_team_id == team_id && game.outcome.include?('home')
        opponent_games_won[game.away_team_id] += 1
      end
    end
    opponent_games_won
  end

  def games_played_vs_opponent_percentage(team_id)
    percentage_won = {}
    games_played_against_opponents(team_id).each do |id, gp|
      percentage_won[id] = games_lost_against_opponents(team_id)[id] / gp.to_f
    end
    percentage_won
  end

  def favorite_opponent(team_id)
    best_opponent = games_played_vs_opponent_percentage(team_id).max_by {|id, pw| pw}
    convert_id_to_name(best_opponent[0])
  end

  def rival(team_id)
    worst_opponent = games_played_vs_opponent_percentage(team_id).min_by {|id, pw| pw}
    convert_id_to_name(worst_opponent[0])
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

  def head_to_head(team_id)
    names_vs_percentage = {}
    games_played_vs_opponent_percentage(team_id).each do |id, percentage|
      names_vs_percentage[convert_id_to_name(id)] = percentage.round(2)
    end
    names_vs_percentage
  end

  def win_percentage(games, team_id)
    return 0.0 if games.empty?
    num_won = 0
    games.each do |game|
      if (team_id == game.home_team_id && game.home_goals > game.away_goals) ||
      (team_id == game.away_team_id && game.home_goals < game.away_goals)
        num_won += 1
      end
    end

    unless games.count == 0.0
      percent_won = (num_won/games.count.to_f).round(2)
    end
  end

  def total_goals_scored(games, team_id)
    return 0 if games.empty?
    num_goals = 0
    games.each do |game|
      if team_id == game.home_team_id
        num_goals += game.home_goals
      elsif team_id == game.away_team_id
        num_goals += game.away_goals
      end
    end
    num_goals
  end

  def total_goals_against(games, team_id)
    return 0 if games.empty?
    num_goals_against = 0
    games.each do |game|
      if team_id == game.home_team_id
        num_goals_against += game.away_goals
      elsif team_id == game.away_team_id
        num_goals_against += game.home_goals
      end
    end
    num_goals_against.round
  end

  def average_goals_scored(games, team_id)
    return 0.0 if games.empty?
    total_scored = total_goals_scored(games, team_id).to_f
    avg_goals = (total_scored/games.count)
    avg_goals.round(2)
  end

  def average_goals_against(games, team_id)
    return 0.0 if games.empty?
    total_against = total_goals_against(games, team_id)
    avg_against = (total_against.to_f/games.count)
    avg_against.round(2)
  end

  def collect_games_by_season(team_id)
    @games.each_with_object(Hash.new) do |game, hash|
      if game.home_team_id == team_id || game.away_team_id == team_id
        if hash[game.season].nil?
          hash[game.season] = [game]
        else
          hash[game.season] << game
        end
      end
    end
  end

  def reg_vs_post(team_id)
    games_by_season = collect_games_by_season(team_id)
    games_by_season.transform_values do |games|
      games.group_by do |game|
        type_to_season(game.type)
      end
    end
  end

  def add_nil_post_regular_season(team_id)
    season_post_reg_hash = reg_vs_post(team_id)
    postseason = {:postseason => []}
    season_post_reg_hash.map do |season, values|
      if values.none? {|value| value.include? :postseason }
        season_post_reg_hash[season].merge!(postseason)
      end
    end
    season_post_reg_hash
  end

  def type_to_season(type)
    if type == 'P'
      return :postseason
    elsif type == 'R'
      return :regular_season
    end
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
    test = summary_hash.transform_values { |v| v.sort.to_h}
  end
end
