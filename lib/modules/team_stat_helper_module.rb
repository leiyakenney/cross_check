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
      percentage_won[id] =  games_lost_against_opponents(team_id)[id] / gp.to_f
    end
    percentage_won
  end

  #========= SEASONAL SUMMARY START =============

  def win_percentage(games, team_id)
    return 'chicken'
  end

  def total_goals_scored(games, team_id)
    'chicken'
  end

  def total_goals_against(games, team_id)
    'taco'
  end

  def average_goals_scored(games, team_id)
    'sushi'
  end

  def average_goals_against(games, team_id)
  'hamburger'
  end



#=========== SEASONAL SUMMARY START ===========

  #Seasonal_summary method
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

  #Seasonal_summary method
  def reg_vs_post(team_id)
    games_by_season = collect_games_by_season(team_id)
    games_by_season.transform_values do |games|
      games.group_by do |game|
        type_to_season(game.type)
      end
    end
  end

  #Seasonal_summary method
  def type_to_season(type)
    if type == 'P'
      return 'postseason'
    elsif type == 'R'
      return 'regular_season'
    end
  end

  #Seasonal_summary method
  #Is this actually doing anything?
  # def setup_reg_season_hash(team_id)
  #   reg_season = {}
  #   reg_season[:regular_season] = {
  #     :win_percentage => 0,
  #     :total_goals_scored => 0,
  #     :total_goals_against => 0,
  #     :average_goals_scored => 0,
  #     :average_goals_against => 0,
  #   }
  #   reg_season
  # end

  # Seasonal_summary method
  # Is this actually doing anything?
  # def setup_post_season_hash(team_id)
  #   post_season = {}
  #   post_season[:postseason] = {
  #     :win_percentage => 0,
  #     :total_goals_scored => 0,
  #     :total_goals_against => 0,
  #     :average_goals_scored => 0,
  #     :average_goals_against => 0,
  #   }
  #   post_season
  # end

  # def seasonal_summary_2(team_id)
  #   season_summary = setup_reg_season_hash(team_id).merge(setup_post_season_hash(team_id))
  # end

  #Seasonal_summary method
  # def seasonal_summary(team_id)
  #   season_summary_of_games = reg_vs_post(team_id)
  #
  #   test = season_summary_of_games.each do |season, sub_hash|
  #     sub_hash.transform_values do |games|
  #
  #       {:win_percentage => win_percentage(games),
  #       :total_goals_scored => total_goals_scored(games),
  #       :total_goals_against => total_goals_against(games),
  #       :average_goals_scored => average_goals_scored(games),
  #       :average_goals_against => average_goals_against(games)}
  #     end
  #   end
  #   test
  # end

  def seasonal_summary(team_id)
    season_summary_of_games = reg_vs_post(team_id)

    season_summary_of_games.transform_values! do |sub_hash|
      #season_summary_of_games.each do |season, sub_hash|
      sub_hash.transform_values do |games|
        {:win_percentage => win_percentage(games, team_id),
        :total_goals_scored => total_goals_scored(games, team_id),
        :total_goals_against => total_goals_against(games, team_id),
        :average_goals_scored => average_goals_scored(games, team_id),
        :average_goals_against => average_goals_against(games, team_id)}
      end
    end
  end
end
