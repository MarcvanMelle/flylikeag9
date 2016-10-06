class ReviewsController < ApplicationController
  def create
    rating = params[:review][:rating]
    review_text = params[:review][:review]
    word = params[:word_id]
    user = current_user
    Review.create(rating: rating, review: review_text, word_id: word, user: user)
    redirect_to word_path(params[:word_id])
  end

  def edit
    @word = Word.find(params[:word_id])
    @review = Review.find(params[:id])
  end

  def update
    review = Review.find(params[:id])
    review.review = params[:review][:review]
    review.rating = params[:review][:rating]
    review.save
    redirect_to word_path(params[:word_id])
  end
end
