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

  def test_wins_by_season
    #{"20122013"=>4, "20132014"=>2, "20142015"=>2}
    assert_equal 10000, @tracker.team_wins_by_season(6)
  end

  def test_num_games_by_season
    #{"20122013"=>4, "20132014"=>3, "20142015"=>2}
    assert_equal 10000, @tracker.num_games_by_season(6)
  end

  def test_avg_win_percent_by_season

    assert_equal 10000, @tracker.avg_win_percent_by_season(6)
  end

  def test_best_season

    assert_equal 20122013, @tracker.best_season(6)
  end

  def test_worst_season

    assert_equal 20132014, @tracker.worst_season(6)
  end
end
