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
    season_collection = {}
    @games.each do |game|
      if game.home_team_id == team_id || game.away_team_id == team_id
        season_collection[game.season] = []
      end
      season_collection[game.season] << game
    end
    season_collection
  end
<<<<<<< HEAD
#
  def reg_vs_post(team_id)
    reg_hash = {}
    post_hash = {}
    season_to_type = {}
    collect_games_by_season(team_id).each do |season, games|
      games.each do |game|
        if game.type == "P"
          post_hash[:postseason] = []
          post_hash[:postseason] << game
        elsif game.type == "R"
          reg_hash[:regular_season] = []
          reg_hash[:regular_season] << game
        end
      end
      season_to_type[season] = post_hash.merge(reg_hash)
    end
    binding.pry
    season_to_type
  end

#   def add_game_data(team_id)
#     collected_data = {}
#     nested_result = {}
#     reg_vs_post(team_id).each do |season, types|
#       game_data = {}
#       types.each do |type, games|
#         game_data[:win_percentage] = 0
#         game_data[:total_goals_scored] = 0
#         game_data[:total_goals_against] = 0
#         game_data[:average_goals_scored] = 0
#         game_data[:average_goals_against] = 0
#         collected_data[type] = game_data
#       end
#       nested_result[season] = collected_data
#     end
#     nested_result
#   end

  # def reg_vs_post(team_id)
  #   reg_hash = {}
  #   post_hash = {}
  #   collect_games_by_season(team_id).each do |season, game|
  #     if game.type == "P"
  #       collect_games_by_season(team_id)[season] = (post_hash[:postseason] = game)
  #     elsif game.type == "R"
  #       collect_games_by_season(team_id)[season] = (reg_hash[:regular_season] = game)
  #     end
  #   end
  #
  #   collect_games_by_season(team_id)
  # end

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
end
