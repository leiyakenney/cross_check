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
end
