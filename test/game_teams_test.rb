require './test/test_helper'

class GameTeamsTest < Minitest::Test

  def test_it_exists
    game_team = GameTeams.new

    assert_instance_of GameTeams, game_team
  end

end
