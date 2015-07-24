class CommitteeController < ApplicationController

  def index
    @committees = Committee.for(committee_params)
  end

  def show
    stub_committee = Committee.new(committee_id: committee_params)
    @donors = stub_committee.donors
    raise "add the view".inspect
  end

  private
    def committee_params
      params[:id]
    end

end
