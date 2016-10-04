class WordsController < ApplicationController
  def index
    @words = Word.all.order!(created_at: :desc).page params[:page]
  end

  def home
    @words = Word.all.order!(created_at: :desc).limit(10)
  end
end
