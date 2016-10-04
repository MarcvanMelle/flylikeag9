class WordsController < ApplicationController
  def index
    @words = Word.all.order!(created_at: :desc).limit(10)
  end
end
