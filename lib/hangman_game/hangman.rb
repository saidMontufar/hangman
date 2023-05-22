require "yaml"


#5. Player must be able to save and load their game - optional

def save_game(word_state, turns_left)
  data = {turns_left: turns_left, word_state: word_state}
  File.open("saved_game/saved_state.yml", "w") do |file|
    file.write(YAML.dump(data))
  end
end

def load_game(variable)
  data = YAML.load_file("saved_game/saved_state.yml")
  data[variable]
end

#1.Start script and radomly select a word  between 5 and 12 characters long
bag_of_words = []
turns_left = 6
puts turns_left
data = open("1000-words.txt").each { |word| word.length > 5 && word.length < 12 ? bag_of_words << word : next}
sample_word = bag_of_words.sample(1)[0].strip.split("")

puts "Welcome to Hangman!"


#2. Display how many guesses are left for the player
puts "You have #{turns_left} attempts left"

#3. Display correct letters that have already been chosen and their position
#4. Each guess has to be case insensitive, display if the guess was correct, if out of guesses p should lose.
word_state = []

sample_word.each {|letter| word_state << "_" }
puts word_state.join
puts "\n\nWhats your first guess?"

while turns_left > 0

  if word_state.include?("_")
    player_guess = gets.chomp

    if sample_word.include?(player_guess)
      puts "Correct guess!"
      sample_word.each_with_index {|letter, idx| player_guess == letter ? (word_state[idx] = letter) : next}
    else
      turns_left -= 1
      puts "Incorrect guess :/"
    end
    puts word_state.join()
    puts "\n\nYou have #{turns_left} attempts left"
    puts "\n\nWhat's your next guess?"
  elsif turns_left <= 0
    puts "You lost!"
    break
  else
    puts "You won!!!"
    break
  end
end


