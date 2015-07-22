class Api::UsuariosController < ApplicationController
  def busca_por_tag
      @record = Acao.find(params[:id])
      if params[:tag].present?
        @usuarios = Usuario.tagged_with(params[:tag]).que_nao_receberam_convite(@record.id).accessible_by(current_ability, :read)
      end
      respond_to do |format|
        format.json { render json: @usuarios }
        format.js
      end
    end
end