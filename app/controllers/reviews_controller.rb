class ReviewsController < ApplicationController
  def create
    rating = params[:review][:rating]
    review_text = params[:review][:review]
    word = params[:word_id]
    user = current_user
    Review.create(rating: rating, review: review_text, word_id: word, user: user)
    redirect_to word_path(params[:word_id])
  end
end
