require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    alphabets = ('A'..'Z').to_a
    @letters = []
    10.times do
      @letters << alphabets.sample
    end
    @letters
  end

  def score
    @input = params[:word].upcase
    @word = @input.split('')
    @letters = params[:letters].split(' ')

    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    @is_word = JSON.parse(URI.open(url).read)['found']

    @output =
      if @is_word
        @valid = @word.all? do |letter|
          @letters.include?(letter)
          @letters.count(letter) >= @word.count(letter)
        end
        @valid ? "Congratulation! #{@input} is a valid English word!" : "Sorry... #{@input} can't be built from the given letters."
      else
        "Sorry... #{@input} does not seem to be a valid English word."
      end
  end
end
