require 'csv'
require 'pry'
require './lib/game'
require './lib/team'
require './lib/game_teams'

class StatTracker

attr_reader :games, :teams, :game_teams

  def initialize(file_names)
    @games = []
    @teams = []
    @game_teams =[]
    from_csv(file_names)
  end

  def from_csv(file_names)
    game_gen(file_names)
    team_gen(file_names)
    game_teams_gen(file_names)
  end

  def game_gen(file_names)
    game_gen = CSV.foreach(file_names[:games],:headers => true) do |row|
      @games.push(Game.new(row))
    end
  end

  def team_gen(file_names)
    team_gen = CSV.foreach(file_names[:teams],:headers => true) do |row|
      @teams.push(Team.new(row))
    end
  end

  def game_teams_gen(file_names)
    game_teams_gen = CSV.foreach(file_names[:game_teams],:headers => true) do |row|
      @game_teams.push(GameTeams.new(row))
    end
    binding.pry
  end

end
