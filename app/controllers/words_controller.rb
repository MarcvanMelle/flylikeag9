class WordsController < ApplicationController
  def index
    @words = Word.all.order!(created_at: :desc).page params[:page]
  end

  def home
    @words = Word.all.order!(created_at: :desc).limit(10)
  end

  def show
    @word = Word.find(params[:id])
    @review = Review.new
    @reviews = @word.reviews
  end

  def edit
    @word = Word.find(params[:id])
  end

  def update
    word = Word.find(params[:id])
    word.definition = params[:word][:definition]
    word.save
    redirect_to word_path(word)
  end
end
