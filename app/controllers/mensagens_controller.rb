class MensagensController < ApplicationController
  @permissao = "Mensagem"
  authorize_resource class: @permissao
  
  def create
    acao = Acao.find(params[:acao])
    @mensagem = Mensagem.new
    @mensagem.texto = params[:mensagem][:texto]
    @mensagem.usuario = current_usuario
    @mensagem.acao = acao
    @mensagem.save
    redirect_to "/crud/acao/#{acao.id}"
  end
end