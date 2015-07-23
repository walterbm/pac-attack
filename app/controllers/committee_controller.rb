class CommitteeController < ApplicationController

  def index
    @committees = Committee.for(committee_params)
  end

  def show
    raise "feature not ready".inspect
    # @committee = Committee.find(committee_params)
  end

  private
  def committee_params
    params[:id]
  end

end
