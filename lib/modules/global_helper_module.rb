module GlobalHelpers
  
  def convert_id_to_name(id)
    team = @teams.find {|team| team.team_id == id}
    team.team_name
  end

  # def change_hash_ids_to_name(hash)
  #  combined_names = {}
  #  hash.each do |team_id, games_won|
  #   combined_names[convert_id_to_name(games_won)] = games_won
  #   end
  #   combined_names
  # end
end
