module GameStats

  def highest_total_score
    @games.max_by {|game| game.data['away_goals'] + game.data['home_goals']}
  end

end
