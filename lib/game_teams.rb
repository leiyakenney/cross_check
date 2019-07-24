class GameTeams

  attr_reader :data, :game_id, :team_id, :hoa, :won, :settled_in, :head_coach, :goals, :shots, :hits, :pim, :ppo, :ppg, :fow, :giveaways, :takeaways

  def initialize(data)
    @game_id = data["game_id"]
    @team_id = data["team_id"]
    @hoa = data["HoA"]
    @won = data["won"]
    @settled_in = data["settled_in"]
    @head_coach = data["head_coach"]
    @goals = data["goals"].to_i
    @shots = data["shots"].to_i
    @hits = data["hits"].to_i
    @pim = data["pim"].to_i
    @ppo = data["powerPlayOpportunities"].to_i
    @ppg = data["powerPlayGoals"].to_i
    #@fow= data["faceOffWinPercentage"].to_f
    #@giveaways = data["giveaways"].to_i
    #@takeaways = data["takeaways"].to_i
  end
end
