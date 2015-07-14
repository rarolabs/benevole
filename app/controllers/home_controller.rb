class HomeController < ApplicationController
  @permissao = "Dashboard"
  authorize_resource class: @permissao
  
  def index
    @acoes = Acao.order(:created_at)
  end
end
