require './lib/game_logic'
include GAME_LOGIC


class Game
  attr_reader :dictionary
  def initialize(dictionary)
    @word = random_word(dictionary)
    @guesses = []
    @errors = 0
    @hint = '_'
  end

  def new_guess
    puts "Make a new guess or save game by typing 'save' or quit by typing 'exit'"
    guess = gets.chomp
    if guess == 'save'
      save
    elsif guess == 'exit'
      @errors = 8
    else
      until guess.match?(/[a-zA-Z_]/)
        puts 'Make a new guess'
        guess = gets.chomp[0]
      end
      @guesses << guess
      @errors += 1 unless @word.include?(guess)
    end
  end

  def start
    while @errors < 7 && @hint.include?('_')
      new_guess
      display
    end

    if @errors == 7
      p "the answer was #{@word}, you blew it"
    else
      p 'congrats, you won'
    end
  end
end
