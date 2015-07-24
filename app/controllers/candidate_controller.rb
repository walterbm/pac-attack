class CandidateController < ApplicationController

  def index
    if candidate_params.empty?
      render "welcome/index"
    else
      @candidates = Candidate.search(candidate_params)
    end
  end

  private
    def candidate_params
      params[:query]
    end
end
