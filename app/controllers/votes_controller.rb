class VotesController < ApplicationController
  def create
    if check_same.nil? && check_oppose.nil?
      vote = Vote.new(vote_params)
      vote.save
    elsif !check_same.nil?
      check_same.destroy
    elsif !check_oppose.nil?
      check_oppose.update(up_down: params[:vote][:up_down])
    end
    render json: count_the_vote.to_json
  end

  private

  def vote_params
    params.require(:vote).permit(:up_down, :review_id).merge(user: current_user)
  end

  def reverse_the_vote
    return "false" if params[:vote][:up_down] == "true"
    return "true" if params[:vote][:up_down] == "false"
  end

  def check_same
    Vote.find_by(user: current_user, review_id: params[:vote][:review_id], up_down: params[:vote][:up_down])
  end

  def check_oppose
    Vote.find_by(user: current_user, review_id: params[:vote][:review_id], up_down: reverse_the_vote)
  end

  def count_the_vote
    review = Review.find(params[:vote][:review_id])
    review.votes.where(review_id: review.id, up_down: "true").count - review.votes.where(review_id: review.id, up_down: "false").count
  end
end
