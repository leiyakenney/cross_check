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
    team_games = @game_teams.select do |game|
       game.team_id == id
     end
    team_games.max_by {|game| game.goals}.goals
  end

  def fewest_goals_scored(id)
    team_games = @game_teams.select do |game|
       game.team_id == id
     end
    team_games.min_by {|game| game.goals}.goals
  end
end
