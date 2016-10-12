class ReviewsController < ApplicationController
  before_action :fetch_review, only: [:edit, :update, :destroy]
  before_action :fetch_word, only: [:edit, :update, :destroy]

  def create
    @review = Review.new(review_params)
    @user = User.find(@review.word.user.id)
    if @review.save
      ReviewMailer.review_notification(@user).deliver_now
      flash[:success] = "Review was saved!"
      redirect_to word_path(params[:word_id])
    else
      flash[:error] = "Review could not be saved"
      render word_path(params[:word_id])
    end
  end

  def edit
  end

  def update
    if authorized_party
      if @review.update(update_review_params)
        flash[:success] = "Review was updated!"
        redirect_to word_path(@word)
      else
        flash[:error] = "Review could not be update"
        render word_path(@word)
      end
    else
      render(file: File.join(Rails.root, 'public/403.html'), status: 403, layout: false)
    end
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

  def review_params
    params.require(:review).permit(:body, :rating).merge(user: current_user).merge(word_id: params[:word_id])
  end

  def update_review_params
    params.require(:review).permit(:body, :rating)
  end

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
