class CandidateController < ApplicationController

  def search
  end

  def index
    @candidates = Candidate.search(candidate_params)
    if candidate_params.empty? || @candidates.empty?
      render :search
    else
      respond_to do |format|
        format.html {render :index}
        format.js {}
      end
    end
  end

  def show
    @candidate = Candidate.find(params[:id])
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
