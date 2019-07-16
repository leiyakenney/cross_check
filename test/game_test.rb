require 'minitest/autorun'
require 'minitest/pride'
# require 'test_helper'
require'./lib/game'


class GameTest < Minitest::Test

  def test_it_exists
    game = Game.new

    assert_instance_of Game, game
  end

end
