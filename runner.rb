require './lib/stat_tracker'
require 'pry'


game_path = './data/dummy_data/dummy_data_game.csv'
team_path = './data/dummy_data/dummy_data_teams.csv'
game_teams_path = './data/dummy_data/dummy_data_game_team.csv'

file_names = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}
<<<<<<< HEAD
stat_tracker = StatTracker.from_csv(file_names)
=======
stat_tracker = StatTracker.new(file_names)
>>>>>>> 35573327156542103a368c8e39c385ad446f32b4
# binding.pry
