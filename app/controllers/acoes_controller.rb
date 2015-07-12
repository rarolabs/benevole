class AcoesController < ApplicationController
  skip_before_filter :authenticate_usuario!, only: [:aceitar, :rejeitar]
  skip_authorize_resource only: [:aceitar, :rejeitar]
  
  def enviar_convite
    @acao = Acao.find(params[:id])
    if params[:envio][:usuarios].present?
      params[:envio][:usuarios].each do |key, value|
        if value == "1"
          Participacao.find_or_create_by(acao_id: @acao.id, usuario_id: key)
        end
      end
    end
    flash[:success] = "Convites enviados com sucesso."
    redirect_to "crud/acao/#{@acao.id}/acao/convidar_usuarios"
  end
  
  def aceitar
    participacao = Participacao.find_by(token: params[:id])
    if participacao.convidado?
      participacao.aceitar!
      flash[:success] = "Seu convite foi registrado como aceito."
    else
      flash[:error] = "Seu convite já esta #{participacao.state}"
    end
    redirect_to root_path
  end
  
  def rejeitar
    participacao = Participacao.find_by(token: params[:id])
    if participacao.convidado?
      participacao.rejeitar!
      flash[:success] = "Seu convite foi registrado como rejeitado."
    else
      flash[:error] = "Seu convite já esta #{participacao.state}"
    end
    redirect_to root_path
  end
end