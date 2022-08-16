class AnswersController < ApplicationController
  before_action :authenticate_user!
  def create
    rank_choice = RankChoice.find(params[:id])
    rank = Rank.find(params[:rank_id])
    user_id = current_user.id
    answer = Answer.new
    answer.answer_count(rank, rank_choice, user_id)
  end
end
