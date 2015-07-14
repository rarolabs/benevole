class AcoesController < ApplicationController
  skip_before_filter :authenticate_usuario!, only: [:aceitar, :rejeitar]
  skip_authorize_resource only: [:aceitar, :rejeitar]

  def show
    @record = Acao.find(params[:id])
    @model = Acao
    @crud_helper = AcaoCrud
    @mensagens = @record.mensagens.order("created_at desc")
    @nova_mensagem = Mensagem.new
  end

  def enviar_convite
    @record = Acao.find(params[:id])
    if params[:envio][:usuarios].present?
      params[:envio][:usuarios].each do |key, value|
        if value == "1"
          Participacao.find_or_create_by(acao_id: @record.id, usuario_id: key)
        end
      end
    end
    flash[:success] = "Convites enviados com sucesso."
    @usuarios = Usuario.que_nao_receberam_convite(@record.id).order(:nome)
  end
  
  def aceitar
    participacao = Participacao.find_by(token: params[:id])
    if participacao.convidado?
      participacao.aceitar!
      flash[:success] = "Seu convite foi registrado como aceito."
    else
      flash[:error] = "Seu convite já esta #{participacao.state}"
    end
    redirect_to new_usuario_session_path
  end
  
  def rejeitar
    participacao = Participacao.find_by(token: params[:id])
    if participacao.convidado?
      participacao.rejeitar!
      flash[:success] = "Seu convite foi registrado como rejeitado."
    else
      flash[:error] = "Seu convite já esta #{participacao.state}"
    end
    redirect_to new_usuario_session_path
  end
end