class AnswersController < ApplicationController
  before_action :authenticate_user!
  def create
    rank_choice = RankChoice.find(params[:id])
    rank = Rank.find(params[:rank_id])
    answer = Answer.new
    answer.rank_id = rank.id
    answer.rank_choice_id = rank_choice.id
    answer.user_id = current_user.id
    answer.save!
  end
end
