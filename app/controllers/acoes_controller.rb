class AcoesController < ApplicationController  
  def enviar_convite
    @acao = Acao.find(params[:id])
    if params[:envio][:usuarios].present?
      params[:envio][:usuarios].keys.each do |usuario|
        ConviteMailer.enviar(@acao.id, usuario.email).deliver_now
      end
    end
  end
end