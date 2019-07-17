class GameTeams

  attr_reader :data, :game_id, :team_id, :HoA, :won, :settled_in, :head_coach, :goals, :shots, :hits, :pim, :ppo, :ppg, :fow, :giveaways, :takeaways

  def initialize(data)
    @game_id = data["game_id"]
    @team_id = data["team_id"]
    @HoA = data["HoA"]
    @won = data["won"]
    @settled_in = data["settled_in"]
    @head_coach = data["head_coach"]
    @goals = data["goals"]
    @shots = data["shots"]
    @hits = data["hits"]
    @pim = data["pim"]
    @ppo = data["powerPlayOpportunities"]
    @ppg = data["powerPlayGoals"]
    @fow= data["faceOffWinPercentage"]
    @giveaways = data["giveaways"]
    @takeaways = data["takeaways"]



  end



end
