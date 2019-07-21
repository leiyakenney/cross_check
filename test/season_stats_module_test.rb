require './test/test_helper'


class SeasonStatsTest < Minitest::Test

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

  def test_game_id_in_season
    skip
  #Name of the Team with the best ratio of shots to goals for the season
  #{"3"=>["2012030225", 29.0], "6"=>["2012030314", 24.0], "5"=>["2012030314", Infinity], "17"=>["2012030231", 21.0]}
  assert_equal 10000, @tracker.game_id_in_season("20122013")
  end

  def test_shot_ratio_within_season
    skip
  assert_equal 100000, @tracker.total_shots_by_season("20122013")
  end

  def test_total_goals_within_season
    skip
  assert_equal 100000, @tracker.total_goals_by_season("20122013")
  end

  def test_shot_ratio_by_season

  assert_equal 10000, @tracker.shot_ratio_by_season("20122013")
  end
end
