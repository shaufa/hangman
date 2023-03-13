require 'pry-byebug'
require './lib/game'
require 'yaml'

dictionary = File.open('dictionary.txt', 'r')
continue = true

puts 'Welcome to HANGMAN'
while continue
  puts 'Choose from menu'
  puts '1 - Start new game'
  puts '2 - Load a game'
  if gets.chomp == '1'
    game = Game.new(dictionary)
    game.start
  else
    puts 'Choose from saved games:'
    Game.display_saved
    choice = gets.chomp.to_i
    game = Game.load(choice)
    game.start
    # binding.pry
  end
  puts 'Do you want to start a new game? (y for yes)'
  continue = false if gets.chomp != 'y'
end