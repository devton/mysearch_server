class SearchesController < ApplicationController
  def show
    render json: { terms: params[:terms] }
  end
end
