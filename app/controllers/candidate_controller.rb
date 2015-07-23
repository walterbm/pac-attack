class CandidateController < ApplicationController

  def index
    @candidates = Candidate.search(candidate_params)
  end

  private
    def candidate_params
      params[:query]
    end
end
