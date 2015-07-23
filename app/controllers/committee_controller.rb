class CommitteeController < ApplicationController

  def index
    @committees = Committee.for(committee_params)
  end

  private
  def committee_params
    params[:id]
  end

end
