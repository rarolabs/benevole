class Api::CidadesController < ApplicationController
  def busca
    respond_to do |format|
      @estado = Estado.find_by(sigla: params[:estado])
      @cidades = @estado.cidades
      format.json  { render json: @cidades }
    end
  end
end