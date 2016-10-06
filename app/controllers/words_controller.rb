class WordsController < ApplicationController
  before_action :fetch_word, only: [:show, :edit, :update, :destroy]

  def index
    @words = Word.all.order!(created_at: :desc).page params[:page]
  end

  def home
    @words = Word.all.order!(created_at: :desc).limit(10)
  end

  def show
    @review = Review.new
    @reviews = @word.reviews
  end

  def edit
  end

  def update
    binding.pry
    @word.definition = params[:word][:definition]
    if authorized_party
      if @word.save
        flash[:success] = "Word was Updated!"
        redirect_to word_path(@word)
      else
        flash[:error] = "Word could not be Updated"
        render word_path(@word)
      end
    else
      render(file: File.join(Rails.root, 'public/403.html'), status: 403, layout: false)
    end
  end

  def destroy
    if authorized_party
      if @word.delete
        flash[:success] = "Word was deleted!"
        redirect_to words_path
      else
        flash[:error] = "Word could not be deleted"
        render word_path(@word)
      end
    else
      render(file: File.join(Rails.root, 'public/403.html'), status: 403, layout: false)
    end
  end

  private

  def fetch_word
    @word = Word.find(params[:id])
  end

  def authorized_party
    current_user.try(:admin?) || current_user == @word.user
  end
end
