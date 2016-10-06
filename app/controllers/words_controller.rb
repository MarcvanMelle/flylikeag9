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

  def destroy
    word = Word.find(params[:id])
    if current_user.try(:admin?) || current_user == word.user
      if word.delete
        flash[:success] = "Word was deleted!"
        redirect_to words_path
      else
        flash[:error] = "Word could not be deleted"
        render word_path(word)
      end
    else
      render(file: File.join(Rails.root, 'public/403.html'), status: 403, layout: false)
    end
  end
end
