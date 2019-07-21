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
      percentage_won[id] =  games_lost_against_opponents(team_id)[id] / gp.to_f
    end
    percentage_won
  end

  def collect_games_by_season(team_id)
    # season_hash = Hash.new
    @games.each_with_object(Hash.new) do |game,hash|
      # hash[game.season] ||= {'regular_season' => [], 'postseason' => []}
      if game.home_team_id == team_id || game.away_team_id == team_id

        # if game.type == 'P'
        #   hash[game.season]['postseason'] << game
        # elsif game.type == 'R'
        #   hash[game.season]['regular_season'] << game
        # end
        if hash[game.season].nil?
          hash[game.season] = [game]
        else
          hash[game.season] << game # this is the important one!
        end
      end
    end

    # season_hash
    # games_with_team = @games.find_all do |game|
    #   game.home_team_id == team_id || game.away_team_id == team_id
    # end
    # games_with_team.group_by do |game|
    #   game.season
    # end
  end

  def season_summary(team_id)
    season_summary_of_games = reg_vs_post(team_id)
    binding.pry
    season_summary_of_games.each do |season, sub_hash|
      sub_hash.transform_values do |games|
        {:win_percentage => win_percentage(games),
        :total_goals_scored => total_goals_scored(games),
        :total_goals_against => total_goals_against(games),
        :average_goals_scored => 3,
        :average_goals_against => 2.2}
      end
    end
  end

  def reg_vs_post(team_id)
    # reg_hash = {}
    # post_hash = {}

    games_by_season = collect_games_by_season(team_id)
    games_by_season.transform_values do |games|
      games.group_by do |game|
        type_to_season(game.type)
      end
      # if game.type == "P"
      #   games_by_season[season] = (post_hash[:postseason] = game)
      # elsif game.type == "R"
      #   games_by_season[season] = (reg_hash[:regular_season] = game)
      # end
    end
    # binding.pry
  end

  def type_to_season(type)
    if type == 'P'
      return 'postseason'
    elsif type == 'R'
      return 'regular_season'
    end
  end

  def setup_reg_season_hash(team_id)
    reg_season = {}
    reg_season[:regular_season] = {
      :win_percentage => 0,
      :total_goals_scored => 0,
      :total_goals_against => 0,
      :average_goals_scored => 0,
      :average_goals_against => 0,
    }
    reg_season
  end

  def setup_post_season_hash(team_id)
    post_season = {}
    post_season[:postseason] = {
      :win_percentage => 0,
      :total_goals_scored => 0,
      :total_goals_against => 0,
      :average_goals_scored => 0,
      :average_goals_against => 0,
    }
    post_season
  end

#this is mine
  def sort_by_season
    new_hash = Hash.new
    new_hash = @games.sort_by {|k, game| game["season"]}
  end

end
