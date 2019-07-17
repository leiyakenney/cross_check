module GameStats

  def highest_total_score
    @games.max_by {|game| (game.data['away_goals'] + game.data['home_goals'])}
  end

  # def lowest_total_score
  #   @games.min_by {|game| (game.data['away_goals'] + game.data['home_goals'])}
  # end

  # def biggest_blowout
  #   @games.max_by {|game| (game.data['away_goals']}
  # end

end
