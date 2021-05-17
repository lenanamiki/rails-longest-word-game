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
    @word = params[:word].upcase.split('')
    @letters = params[:letters].split(' ')

    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    @is_word = JSON.parse(URI.open(url).read)['found']

    @output =
      if @is_word
        @valid = @word.all? do |letter|
          @letters.include?(letter)
          @letters.count(letter) >= @word.count(letter)
        end
        @valid ? "Congratulation! #{params[:word].upcase} is a valid English word!" : "Sorry... #{params[:word].upcase} can't be built from the given letters."
      else
        "Sorry... #{params[:word].upcase} does not seem to be a valid English word."
      end
  end
end
