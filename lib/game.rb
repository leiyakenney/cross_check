class Game

  attr_reader :data, :games, :game_id

  def initialize(data)
    @data = data
    @game_id = data["game_id"]
  end

end
