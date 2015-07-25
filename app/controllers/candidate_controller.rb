class CandidateController < ApplicationController

  def search
  end

  def index
    if candidate_params.empty?
      render "welcome/index"
    else
      @candidates = Candidate.search(candidate_params)
    end
  end

  def show
    @candidate_id = params[:id]
  end

  def d3_json
    candidate = Candidate.find(params[:id])
    @json_data = candidate.d3_hash
    render json: @json_data
  end

  private
    def candidate_params
      params[:query]
    end
end
