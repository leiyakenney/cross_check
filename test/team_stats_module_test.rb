require './test/test_helper'

class TeamStatsTest < Minitest::Test

  def setup
    game_path = './data/dummy_data/dummy_data_game.csv'
    team_path = './data/dummy_data/dummy_data_teams.csv'
    game_teams_path = './data/dummy_data/dummy_data_game_team.csv'
    @file_names = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @tracker = StatTracker.from_csv(@file_names)
  end

  def test_team_info
    expected = {"team_id" => "1", "franchise_id" => "23", "short_name" => "New Jersey", "team_name" => "Devils", "abbreviation" => "NJD", "link" => "/api/v1/teams/1" }
    assert_equal expected, @tracker.team_info("1")
  end

  def test_favorite_opponent
    assert_equal 'Penguins', @tracker.favorite_opponent("6")
  end

  def test_biggest_team_blowout
    assert_equal 1, @tracker.biggest_team_blowout("3")
  end

  def test_worst_loss
    assert_equal 3, @tracker.worst_loss("3")
  end

  def test_rival
    assert_equal 'Rangers', @tracker.rival("6")
  end

  def test_head_to_head
    expected = {"Rangers"=>0.8, "Penguins"=>1.0}
    assert_equal expected, @tracker.head_to_head("6")
  end

  #For each season that the team has played, a hash that has two keys
  #(:regular_season and :postseason), that each point to a hash with the
  #following keys: :win_percentage, :total_goals_scored, :total_goals_against,
  # :average_goals_scored, :average_goals_against.

  def test_seasonal_summary
    expected = {
      :regular_season => {
        :win_percentage => 0.68,
        :total_goals_scored => 100,
        :total_goals_against => 80,
        :average_goals_scored => 3,
        :average_goals_against => 2.2
      },
      :postseason => {
        :win_percentage => 0.55,
        :total_goals_scored => 20,
        :total_goals_against => 9,
        :average_goals_scored => 4,
        :average_goals_against => 3.1
      }
    }
    assert_equal expected, @tracker.test_seasonal_summary("6")
  end
end
