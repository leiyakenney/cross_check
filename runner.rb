require './lib/stat_tracker'
require 'pry'

game_path = './data/dummy_data/dummy_data_game.csv'
team_path = './data/dummy_data/dummy_data_teams.csv'
game_teams_path = './data/dummy_data/dummy_data_game_team.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}
stat_tracker = StatTracker.from_csv(locations)
# binding.pry
