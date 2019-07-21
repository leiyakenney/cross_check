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

  expected = ["2012030221", "2012030222", "2012030313", "2012030314", "2012030231", "2012030232", "2012030233", "2012030234", "2012030235", "2012030236", "2012030237", "2012030121", "2012030122", "2012030123"]
  assert_equal expected, @tracker.game_id_in_season("20132014")
  end

  def test_shot_ratio_within_season
  total_shots_by_team = {"3"=>72, "6"=>144, "5"=>80, "17"=>21}
  assert_equal total_shots_by_team, @tracker.total_shots_by_season("20132014")
  end

  def test_total_goals_by_season
  expected = {"3"=>4, "6"=>11, "5"=>1, "17"=>1}
  assert_equal expected, @tracker.total_goals_by_season("20132014")
  end

  def test_shot_ratio_by_season
  expected = {"3"=>18.0, "6"=>13.090909090909092, "5"=>80.0, "17"=>21.0}
  assert_equal expected, @tracker.shot_ratio_by_season("20132014")
  end

  def test_minmax_shot_ratio_by_season
  expected = [["6", 13.090909090909092], ["5", 80.0]]
  assert_equal expected, @tracker.minmax_shot_ratio_by_season("20132014")
  end

  def test_most_accurate_team

  assert_equal "Bruins", @tracker.most_accurate_team("20132014")
  end

  def test_least_accurate_team

  assert_equal "Penguins", @tracker.least_accurate_team("20132014")
  end
end
