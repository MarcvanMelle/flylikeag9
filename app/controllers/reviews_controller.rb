class ReviewsController < ApplicationController
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
end
