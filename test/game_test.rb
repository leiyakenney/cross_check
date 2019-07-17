require 'minitest/autorun'
require 'minitest/pride'
require './test/test_helper'
require './lib/game'


class GameTest < Minitest::Test

  def setup
    @data = {"game_id"=>"2012030221", "season"=>"20122013", "type"=>"P", "date_time"=>"2013-05-16", "away_team_id"=>"3", "home_team_id"=>"6", "away_goals"=>"2", "home_goals"=>"3", "outcome"=>"home win OT", "home_rink_side
_start"=>"left", "venue"=>"TD Garden", "venue_link"=>"/api/v1/venues/null", "venue_time_zone_id"=>"America/New_York", "venue_time_zone_offset"=>"-4", "venue_time_zone_tz"=>"EDT"}
    @game = Game.new(@data)
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_attributes
    assert_equal "2012030221", @game.game_id
    assert_equal "2", @game.away_goals
  end

end
