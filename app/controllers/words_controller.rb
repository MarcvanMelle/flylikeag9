class WordsController < ApplicationController

  def index
    all_words = Word.all.order!(created_at: :desc)
    @words = all_words[0..9]
  end

end
