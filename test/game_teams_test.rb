require 'minitest/autorun'
require 'minitest/pride'
require './test/test_helper'
require'./lib/game_teams'


class GameTeamsTest < Minitest::Test

  def test_it_exists
    game_team = GameTeams.new

    assert_instance_of GameTeams, game_team
  end

end
