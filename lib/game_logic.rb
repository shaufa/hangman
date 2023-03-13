module GAME_LOGIC
  def random_word(dictionary)
    dictionary.rewind
    dictionary.readlines.each_with_object([]) do |word, accumulator|
      accumulator.push(word.chomp) if word.chomp.length >= 5 && word.chomp.length <= 12
    end.sample
  end

  def display
    guessed = Regexp.new("[^#{@guesses}]", Regexp::IGNORECASE)
    @hint = @word.gsub(guessed, '_')
    puts "Guesses: #{@guesses.select { |v| v unless @word.include?(v) }.join(', ')}"
    puts "Errors: #{@errors}"
    puts "Word: #{@hint}"
  end

  def save(game_name = 'hangman')
    time = Time.now.to_s.split(' ').map { |v| v.gsub(/-/, '').gsub(/:/, '') }
    Dir.mkdir('saved_games') unless Dir.exist?('saved_games')
    backup = File.open("saved_games/#{game_name}-backup-#{time[0]}-#{time[1]}.yaml", 'w')
    backup << YAML.dump(self)
    backup.close
  end

  def load(saved_game)
    saved_games = Dir['./saved_games/*.yaml'].sort_by { |v| File.birthtime(v)}
    YAML.safe_load(File.read(saved_games[saved_game - 1]), permitted_classes: [Game])
  end

  def display_saved
    saved_games = Dir['./saved_games/*.yaml'].sort_by { |v| File.birthtime(v)}
    if saved_games.empty?
      puts 'No games saved'
    else
      saved_games.each_with_index do |game, i|
        d = File.birthtime(game)
        puts "#{i + 1}. #{game.split('/')[2].split('.')[0].split('-')[0]} - #{d.strftime('saved on %d/%m/%Y at %H:%M:%S')}"
      end
    end
  end
end