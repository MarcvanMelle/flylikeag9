class SearchController < ApplicationController
  def index
    @word_results = Word.where("word LIKE (?)", "%#{params[:search]}%")
    if @word_results.empty?
      flash[:error] = "Word could not be found"
      redirect_to words_path
    elsif params[:search] == ""
      flash[:error] = "You must enter something"
      redirect_to words_path
    end
  end
end
