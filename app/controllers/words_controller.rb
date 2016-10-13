class WordsController < ApplicationController
  before_action :fetch_word, only: [:show, :edit, :update, :destroy]

  def index
    @words = Word.all.order!(created_at: :desc).page params[:page]
    respond_to do |format|
      format.html
      format.json do
        response_array = []
        @words.each do |word|
          response_array << { id: word.id, word: word.word }
        end
        render json: response_array.to_json
      end
    end
  end

  def home
    @words = Word.all.order(created_at: :desc).limit(10)
  end

  def show
    @review = Review.new
    @reviews = @word.reviews
    @default_image = "Man_Silhouette.jpg"
  end

  def new
    if current_user
      @word = Word.new
    else
      flash[:errors] = "You must be logged in to create a word."
      redirect_to root_path
    end
  end

  def create
    if current_user
      @word = Word.new(word_params)
      if @word.save
        flash[:success] = "Word up!"
        redirect_to root_path
      else
        flash[:errors] = "Word could not be created."
        render :new
      end
    end
  end

  def edit
  end

  def update
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

  def word_params
    params.require(:word).permit(:word, :definition).merge(user: current_user)
  end

  def fetch_word
    @word = Word.find(params[:id])
  end

  def authorized_party
    current_user.try(:admin?) || current_user == @word.user
  end
end
