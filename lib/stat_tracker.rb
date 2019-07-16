require 'csv'
require 'pry'

class StatTracker

  def initialize
    @games = []
    @teams = []
    @game_teams = []
    @season = []
  end

  def self.from_csv(files)
    # games = files[:games]
    games = CSV.foreach(files[:games],:headers => true) do |row|
      binding.pry
    end
    games.each do |row|
    end
    StatTracker.new(games)
  end

  def highest_total_score
    @games.max_by do |game|
      (game.winning_score + game.losing_score)
    end
  end
end
