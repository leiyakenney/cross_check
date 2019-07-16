require 'csv'
require 'pry'

class StatTracker

  def initialize(games)
    @games = games
  end

  def self.from_csv(files)
    # games = files[:games]
    CSV.foreach(files[:games],:headers => true) do |row|

      binding.pry
    end
  end

  # def highest_total_score
  #   @games.max_by do |game|
  #     (game.winning_score + game.losing_score)
  #   end
  # end
end
