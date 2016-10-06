class ReviewsController < ApplicationController
  before_action :fetch_review, only: [:edit, :update, :destroy]
  before_action :fetch_word, only: [:edit, :destroy]

  def create
    rating = params[:review][:rating]
    body = params[:review][:body]
    word = params[:word_id]
    user = current_user
    Review.create(rating: rating, body: body, word_id: word, user: user)
    redirect_to word_path(params[:word_id])
  end

  def edit
    @word = Word.find(params[:word_id])
    @review = Review.find(params[:id])
  end

  def update
    review = Review.find(params[:id])
    review.body = params[:review][:body]
    review.rating = params[:review][:rating]
    review.save
    redirect_to word_path(params[:word_id])
  end

  def destroy
    if authorized_party
      if @review.delete
        flash[:success] = "Review was deleted!"
        redirect_to word_path(@word)
      else
        flash[:error] = "Review could not be deleted"
        render word_path(@word)
      end
    else
      render(file: File.join(Rails.root, 'public/403.html'), status: 403, layout: false)
    end
  end

  private

  def fetch_review
    @review = Review.find(params[:id])
  end

  def fetch_word
    @word = Word.find(params[:word_id])
  end

  def authorized_party
    current_user.try(:admin?) || current_user == @review.user
  end
end
