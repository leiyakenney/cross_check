module TeamStats


  def best_season
    @teams.max_by do |team|
      (team.data[])
  end

end
