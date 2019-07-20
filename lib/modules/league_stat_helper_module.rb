module LeagueStatHelpers

  def home_games_played
    games_home_played = Hash.new(0)
    @games.each do |game|
      games_home_played[game.home_team_id] += 1
    end
    games_home_played
  end

  def away_games_played
    games_away_played = Hash.new(0)
    @games.each do |game|
      games_away_played[game.away_team_id] += 1
    end
    games_away_played
  end

  def total_games_played
    total_games_played = away_games_played.merge!(home_games_played) do |id, ag, hg|
      ag + hg
    end
  end

  def home_team_goals
    goals_home_team = Hash.new(0)
    @games.each do |game|
      goals_home_team[game.home_team_id] += game.home_goals
    end
    goals_home_team
  end

  def away_team_goals
    goals_away_team = Hash.new(0)
    @games.each do |game|
      goals_away_team[game.away_team_id] += game.away_goals
    end
    goals_away_team
  end

  def total_goals_by_game_team
    total_goal_by_team = Hash.new(0)
    @game_teams.each do |game|
      total_goal_by_team[game.team_id] += game.goals.to_f
    end
    total_goal_by_team
  end

  def total_games_by_game_team
   total_games_by_teams = Hash.new(0)
   @game_teams.each do |game|
      total_games_by_teams[game.team_id] += 1
    end
    total_games_by_teams
  end

  def average_offense
    avg_offense = Hash.new
    total_goals_by_game_team.map do |team_id, total_goals|
      avg_offense[team_id] = (total_goals_by_game_team[team_id]/total_games_by_game_team[team_id]).round(2)
    end
    avg_offense
  end

  def home_team_goals_against
    goals_against_home_team = Hash.new(0)
    @games.each do |game|
      goals_against_home_team[game.home_team_id] += game.away_goals
    end
    goals_against_home_team
  end

  def away_team_goals_against
    goals_against_away_team = Hash.new(0)
    @games.each do |game|
      goals_against_away_team[game.away_team_id] += game.home_goals
    end
    goals_against_away_team
  end

  def total_goals_against
    total_goals_against = away_team_goals_against.merge!(home_team_goals_against) do |id, aga, hga|
      aga + hga
    end
    total_goals_against
  end

  def games_won_game_team
    game_team_wins = Hash.new(0)
    @game_teams.each do |game|
      if game.won == 'TRUE'
        game_team_wins[game.team_id] += 1
      end
    end
    game_team_wins
  end

  def total_home_wins_by_team
    home_wins = Hash.new(0)
    @game_teams.each do |team|
      if team.won && team.hoa == 'home'
        home_wins[team.team_id] += 1
      end
    end
    home_wins
  end

  def home_wins_percentage_by_team
    win_percentages = total_home_wins_by_team.merge(total_games_by_game_team){|team, win, games| win/games.to_f}
    max = win_percentages.max_by{|k,v| v}
    max[1].round(2)
  end

  def total_away_wins_by_team
    away_wins = Hash.new(0)
    @game_teams.each do |team|
      if team.won && team.hoa == 'away'
        away_wins[team.team_id] += 1
      end
    end
    away_wins
  end

  def away_wins_percentage_by_team
    aw_percentages = total_away_wins_by_team.merge(total_games_by_game_team){|team, win, games| win/games.to_f}
    max = aw_percentages.max_by{|k,v| v}
    max[1].round(2)
  end

  def home_game_team_wins
    home_game_team_win = Hash.new(0)
      @game_teams.find_all do |game|
        if game.won == 'TRUE' && game.hoa == 'home'
        home_game_team_win[game.team_id] += 1
        end
      end
    home_game_team_win
  end

  def away_game_team_wins
    away_game_team_wins = Hash.new(0)
      @game_teams.find_all do |game|
        if game.won == 'TRUE' && game.hoa == 'away'
        away_game_team_wins[game.team_id] += 1
        end
      end
    away_game_team_wins
  end

  def total_home_games_played
    total_home_games_played = Hash.new(0)
    @game_teams.each do |game|
      if game.hoa == 'home'
      total_home_games_played[game.team_id] += 1
      end
    end
    total_home_games_played
  end

  def total_away_games_played
    total_away_game_played = Hash.new(0)
    @game_teams.each do |game|
      if game.hoa == 'away'
      total_away_game_played[game.team_id] += 1
      end
    end
    total_away_game_played
  end

  def percent_of_home_games_won
    percent_of_home_games_won = Hash.new(0)
      home_game_team_wins.map do |team_id, home_wins|
      percent_of_home_games_won[team_id] = home_wins/total_home_games_played[team_id].to_f
    end
    percent_of_home_games_won
  end

  def percent_of_away_games_won
    percent_of_away_games_won = Hash.new(0)
      away_game_team_wins.map do |team_id, away_wins|
      percent_of_away_games_won[team_id] = away_wins/total_away_games_played[team_id].to_f
    end
    percent_of_away_games_won
  end

  def difference_home_vs_away_won
    difference_home_vs_away_won = Hash.new(0)
      percent_of_home_games_won.map do |team_id, home_win|
      difference_home_vs_away_won[team_id] = home_win - percent_of_away_games_won[team_id]
    end
    difference_home_vs_away_won
  end

  def most_goals_scored(id)
    team_games = @game_teams.select do |game|
       game.team_id == id
     end
    team_games.max_by {|game| game.goals}.goals
  end
end
