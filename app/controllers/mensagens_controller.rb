class MensagensController < ApplicationController

  def create
    acao = Acao.find(params[:acao])
    @mensagem = Mensagem.new
    @mensagem.texto = params[:texto]
    @mensagem.usuario = current_usuario
    @mensagem.acao = acao
    @mensagem.save
    redirect_to "/crud/acao/#{acao.id}"
  end
end