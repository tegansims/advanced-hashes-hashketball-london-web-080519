# Write your code here!

require "pry"

def game_hash
  game_hash = {
    :home => {
      :team_name => "Brooklyn Nets", 
      :colors => ["Black", "White"], 
      :players => [
        "Alan Anderson" => {:number => 0, :shoe => 16, :points => 22,	:rebounds => 12,	:assists => 12,	:steals => 3, :blocks => 1,	:slam_dunks => 1},
        "Reggie Evans" => {:number => 30, :shoe => 14,	:points => 12,	:rebounds => 12,	:assists => 12,	:steals => 12, :blocks => 12,	:slam_dunks => 7},
        "Brook Lopez" => {:number => 11, :shoe => 17,	:points => 17 ,	:rebounds => 19,	:assists => 10,	:steals => 3, :blocks => 1,	:slam_dunks => 15},
        "Mason Plumlee" => {:number => 1, :shoe => 19,	:points => 26,	:rebounds => 11,	:assists => 6,	:steals => 3, :blocks => 8,	:slam_dunks => 5},
        "Jason Terry"=> {:number => 31, :shoe => 15,	:points => 19,	:rebounds => 2,	:assists => 2,	:steals => 4, :blocks => 11,	:slam_dunks => 1}
        ]
    },
    :away => {
      :team_name => "Charlotte Hornets", 
      :colors => ["Turquoise", "Purple"],
      :players => [
        "Jeff Adrien" => {:number => 4, :shoe => 18,	:points => 10,	:rebounds => 1,	:assists => 1,	:steals => 2, :blocks => 7,	:slam_dunks =>2 }, 
        "Bismack Biyombo" => {:number => 0, :shoe => 16, :points => 12,	:rebounds => 4,	:assists => 7,	:steals => 22, :blocks => 15,	:slam_dunks => 10},
        "DeSagna Diop" => {:number => 2, :shoe => 14,	:points => 24,	:rebounds => 12,	:assists => 12,	:steals => 4, :blocks => 5,	:slam_dunks => 5},
        "Ben Gordon" => {:number => 8, :shoe => 15,	:points => 33,	:rebounds => 3,	:assists => 2,	:steals => 1, :blocks => 1,	:slam_dunks => 0},
        "Kemba Walker" => {:number => 33, :shoe => 15,	:points => 6,	:rebounds => 12,	:assists => 12,	:steals => 7, :blocks => 5,	:slam_dunks =>12}
        ]
    }
  }
  game_hash
 # binding.pry
end

def num_points_scored(player)
  if game_hash[:home][:players][0].keys.include?(player)
    points = game_hash[:home][:players][0][player][:points]
  elsif game_hash[:away][:players][0].keys.include?(player)
    points = game_hash[:away][:players][0][player][:points]
  end
  points
end

def shoe_size(player)
  if game_hash[:home][:players][0].keys.include?(player)
    points = game_hash[:home][:players][0][player][:shoe]
  elsif game_hash[:away][:players][0].keys.include?(player)
    points = game_hash[:away][:players][0][player][:shoe]
  end
end

def team_colors(team_name)
  if game_hash[:home][:team_name].include?(team_name)
    colors = game_hash[:home][:colors]
  elsif game_hash[:away][:team_name].include?(team_name)
    colors = game_hash[:away][:colors]
  end
  colors
end

def team_names
  team_names_hash = []
  team_names_hash << game_hash[:home][:team_name]
  team_names_hash << game_hash[:away][:team_name]
  team_names_hash
end

def player_numbers(team_name)
  player_numbers_hash = []
  # check if right team_name 
  if game_hash[:home][:team_name].include?(team_name)
    # collect each jersey number; add each one to player_numbers_hash
    player_hash = game_hash[:home][:players][0].keys
    player_hash.each do |x|
      player_numbers_hash << game_hash[:home][:players][0][x][:number]
    end
  elsif game_hash[:away][:team_name].include?(team_name)
    player_hash = game_hash[:away][:players][0].keys
    player_hash.each do |x|
      player_numbers_hash << game_hash[:away][:players][0][x][:number]
    end
  end 
  player_numbers_hash
end

def player_stats(player)
  player_stats_hash = {}
  if game_hash[:home][:players][0].keys.include?(player)
    game_hash[:home][:players][0][player]
  elsif game_hash[:away][:players][0].keys.include?(player)
    game_hash[:away][:players][0][player]
  end
end

def big_shoe_rebounds
  # find player with largest shoe size 
  players = []
  players << game_hash[:home][:players][0].keys
  players << game_hash[:away][:players][0].keys
  players.flatten!
  # run shoe_size on each of the elements in the players array
  players_shoe_size = {}
  players.each { |x| players_shoe_size[shoe_size(x)] = x } # putting the shoe size as the key and the player name as the value, so we can then sort by size
  biggest_shoe_player = players_shoe_size.sort[-1] #calling the last one, ie the biggest
  
  # return that player's number of rebounds
  if game_hash[:home][:players][0].keys.include?(biggest_shoe_player[1])
    answer = game_hash[:home][:players][0][biggest_shoe_player[1]][:rebounds]
  elsif game_hash[:away][:players][0].keys.include?(biggest_shoe_player[1])
    answer = game_hash[:away][:players][0][biggest_shoe_player[1]][:rebounds]
  end
  answer
end

# ------- # ------- # ------- BONUS # ------- #------- #--------

def most_points_scored
  players = []
  players << game_hash[:home][:players][0].keys
  players << game_hash[:away][:players][0].keys
  players.flatten!
  # run shoe_size on each of the elements in the players array
  players_points = {}
  players.each { |x| players_points[num_points_scored(x)] = x } 
  biggest_pointer = players_points.sort[-1][1]
end

def winning_team
  home_players = []
  home_players << game_hash[:home][:players][0].keys
  home_points = []
  home_players.flatten.each { |x| home_points << num_points_scored(x)}
  home_points_total = home_points.reduce(:+)
  
  away_players = []
  away_players << game_hash[:away][:players][0].keys
  away_points = []
  away_players.flatten.each { |x| away_points << num_points_scored(x) }
  away_points_total = away_points.reduce(:+)
 
  home_points_total > away_points_total ? game_hash[:home].values[0] : game_hash[:away].values[0]
  
end

def player_with_longest_name
  players = []
  players << game_hash[:home][:players][0].keys
  players << game_hash[:away][:players][0].keys
  players.flatten!
  
  longest_name = players[0]
  players.each do |x|
    
    if x.length > longest_name.length
       longest_name = x
    else
      longest_name = longest_name
    end
    
  end
  longest_name
end

def steals(player)
  if game_hash[:home][:players][0].keys.include?(player)
    steals = game_hash[:home][:players][0][player][:steals]
  elsif game_hash[:away][:players][0].keys.include?(player)
    steals = game_hash[:away][:players][0][player][:steals]
  end
  steals
end

def long_name_steals_a_ton?
  players = []
  players << game_hash[:home][:players][0].keys
  players << game_hash[:away][:players][0].keys
  players.flatten!
  
  players_steals = {}
  players.each { |x| players_steals[steals(x)] = x } 
  biggest_stealer = players_steals.sort[-1][1]
  
  biggest_stealer == player_with_longest_name
  
end
