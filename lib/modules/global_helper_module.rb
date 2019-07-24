module GlobalHelpers

  def convert_id_to_name(id)
    team = @teams.find {|team| team.team_id == id}
    team.team_name
  end

end
