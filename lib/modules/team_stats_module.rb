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
