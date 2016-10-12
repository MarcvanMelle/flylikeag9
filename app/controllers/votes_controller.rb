class VotesController < ApplicationController

  def create
    reverse_vote = "false" if params[:vote][:up_down] == "true"
    reverse_vote = "true" if params[:vote][:up_down] == "false"
    check_same_votes = Vote.find_by(user: current_user, review_id: params[:vote][:review_id], up_down: params[:vote][:up_down])
    check_oppose_votes = Vote.find_by(user: current_user, review_id: params[:vote][:review_id], up_down: reverse_vote)
    if check_same_votes.nil? && check_oppose_votes.nil?
      vote = Vote.new(vote_params)
      vote.save
    elsif !check_same_votes.nil?
      check_same_votes.destroy
    elsif !check_oppose_votes.nil?
      check_oppose_votes.update(up_down: params[:vote][:up_down])
    end
    review = Review.find(params[:vote][:review_id])
    vote_count = review.votes.where(review_id: review.id, up_down: "true").count - review.votes.where(review_id: review.id, up_down: "false").count
    render json: vote_count.to_json
  end

  private

  def vote_params
    params.require(:vote).permit(:up_down, :review_id).merge(user: current_user)
  end
end
