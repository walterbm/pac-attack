class CandidateController < ApplicationController

  def index
    if candidate_params.empty?
      render "welcome/index"
    else
      @candidates = Candidate.search(candidate_params)
    end
  end

  def show
    @test = {
             "name": "flare",
             "children": [
              {
               "name": "PAC LEVEL 1 (ORG #1)",
               "children": [
                {
                 "name": "PAC LEVEL 2 (ORG #1)",
                 "children": [
                  {"name": "AgglomerativeCluster", "size": 100000},
                  {"name": "CommunityStructure", "size": 3812},
                  {"name": "HierarchicalCluster", "size": 6714},
                  {"name": "MergeEdge", "size": 743}
                 ]
                },
                {
                 "name": "PAC LEVEL 2 (ORG #2)",
                 "children": [
                  {"name": "BetweennessCentrality", "size": 3534},
                  {"name": "LinkDistance", "size": 5731},
                  {"name": "MaxFlowMinCut", "size": 7840},
                  {"name": "ShortestPaths", "size": 5914},
                  {"name": "SpanningTree", "size": 3416}
                 ]
                }
               ]
              }
             ]
            }
    candidate = Candidate.find(params[:id])
    # working on d3_data method
    # @json_data = candidate.d3_data
    render json: @test
  end

  private
    def candidate_params
      params[:query]
    end
end
