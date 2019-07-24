require 'csv'
require 'pry'
require_relative './game'
require_relative './teams'
require_relative './game_teams'
require_relative './modules/game_stats_module'
require_relative './modules/league_stats_module'
require_relative './modules/team_stats_module'
require_relative './modules/team_stat_helper_module'
require_relative './modules/season_stat_helper_module'
require_relative './modules/season_stat_module'
require_relative './modules/global_helper_module'
require_relative './modules/season_stat_module'
require_relative './modules/season_stat_helper_module'

class StatTracker
  include GameStats
  include GlobalHelpers
  include LeagueStats
  include TeamStats
  include TeamStatHelpers
  include SeasonStat
  include SeasonStatHelper

  attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(file_names)
    games = game_gen(file_names)
    teams = teams_gen(file_names)
    game_teams = game_teams_gen(file_names)
    StatTracker.new(games, teams, game_teams)
  end

  def self.game_gen(file_names)
    game_arr = []
    CSV.foreach(file_names[:games],:headers => true) do |row|
      game_arr.push(Game.new(row))
    end
    game_arr
  end

  def self.teams_gen(file_names)
    teams_arr = []
    CSV.foreach(file_names[:teams],:headers => true) do |row|
      teams_arr.push(Team.new(row))
    end
    teams_arr
  end

  def self.game_teams_gen(file_names)
    game_teams_arr = []
    CSV.foreach(file_names[:game_teams],:headers => true) do |row|
      game_teams_arr.push(GameTeams.new(row))
    end
    game_teams_arr
  end


end
