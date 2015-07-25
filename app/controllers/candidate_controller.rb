class CandidateController < ApplicationController

  def search
  end

  def index
    @candidates = Candidate.search(candidate_params)
    if candidate_params.empty? || @candidates.empty?
      render :search
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
