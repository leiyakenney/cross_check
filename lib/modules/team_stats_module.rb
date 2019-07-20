module TeamStats


  def team_info(team_id)
    info_hash = {}
    find_team = @teams.find {|team| team.team_id.to_s == team_id}
    find_team.instance_variables.each do |variable|
      info_hash[variable.to_s.delete("@")] = find_team.instance_variable_get(variable).to_s
  end
  info_hash
  end
end
