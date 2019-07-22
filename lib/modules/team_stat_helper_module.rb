require 'pry'
module TeamStatHelpers

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

  #========= SEASONAL SUMMARY HELPER START =============

  def win_percentage(games, team_id)
     # binding.pry
    return 0.0 if games.nil?

    num_won = 0
    games.each do |game|
      if team_id == game.home_team_id && game.home_goals > game.away_goals
        num_won += 1
      elsif team_id == game.away_team_id && game.home_goals < game.away_goals
        num_won += 1
      end
    end

      unless games.count == 0.0
        #if it 0 DON'T DO THIS
      percent_won = (num_won/games.count).to_f
      percent_won.round(2)
    end
  end


  def total_goals_scored(games, team_id)

    return 0 if games.nil?

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

    return 0 if games.nil?

    num_goals_against = 0
    games.each do |game|
      if team_id == game.home_team_id
        num_goals_against += game.away_goals
      elsif team_id == game.away_team_id
        num_goals_against += game.home_goals
      end
    end
    num_goals_against.round(2)
  end

  def average_goals_scored(games, team_id)

    return 0.0 if games.nil?

    total_scored = total_goals_scored(games, team_id).to_f

    avg_goals = (total_scored/games.count).to_f
    avg_goals.round(2)
  end

  def average_goals_against(games, team_id)

    return 0.0 if games.nil?

    total_against = total_goals_against(games, team_id)

    avg_against = (total_against.to_f/games.count.to_f)
    avg_against.round(2)
  end



#=========== SEASONAL SUMMARY START ===========

  #Seasonal_summary method
  def collect_games_by_season(team_id)

    @games.each_with_object(Hash.new) do |game, hash|
      if game.home_team_id == team_id || game.away_team_id == team_id
        if hash[game.season].nil?
          hash[game.season] = [game]
        else
          hash[game.season] << game
        end
      end
      # binding.pry
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
    #binding.pry
    # if transform_values.values.none? {|}:postseason
  end


  #Seasonal_summary method
  def type_to_season(type)
    if type == 'P'
      return :postseason
    elsif type == 'R'
      return :regular_season
    end
  end

  def seasonal_summary(team_id)
    season_summary_of_games = add_nil_post_regular_season(team_id)
    #season_summary_of_games = reg_vs_post(team_id)
#binding.pry
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
    #sorts to postseason first, needs to sort to regularseason
    #postseason first
    test = summary_hash.transform_values { |v| v.sort.to_h}
    #optional?????

    #regularseason first
    #summary_hash.transform_values { |v| v.sort { |k, v| v <=> k }.to_h}
    test
    #from stackover flow https://stackoverflow.com/users/2035262/aleksei-matiushkin
  end
end
