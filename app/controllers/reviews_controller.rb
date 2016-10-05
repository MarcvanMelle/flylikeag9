class ReviewsController < ApplicationController
  def create
    review = Review.new(rating: params[:review][:rating], review: params[:review][:review], word_id: params[:word_id], user: current_user)
    review.save
    redirect_to word_path(params[:word_id])
  end
end
