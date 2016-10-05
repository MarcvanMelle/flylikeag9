class ReviewsController < ApplicationController
  def create
    rating = params[:review][:rating]
    review = params[:review][:review]
    word = params[:word_id]
    user = current_user
    review = Review.new(rating: rating, review: review, word_id: word, user: user)
    review.save
    redirect_to word_path(params[:word_id])
  end
end
