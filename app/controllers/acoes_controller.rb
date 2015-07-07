class AcoesController < ApplicationController  
  def enviar_convite
    @acao = Acao.find(params[:id])
    if params[:envio][:usuarios].present?
      params[:envio][:usuarios].keys.each do |usuario|
        Participacao.create(acao: @acao, usuario: @usuario)
      end
    end
  end
end