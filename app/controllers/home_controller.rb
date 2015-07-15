class HomeController < ApplicationController
  @permissao = "Dashboard"
  authorize_resource class: @permissao
  
  def index
    @acoes = Acao.where(state: [:nova,:em_andamento]).order(:created_at)
    @quantidade_de_voluntarios = Usuario.accessible_by(current_ability).joins(:papel).where("papeis.chave = 'voluntario'").count
    @quantidade_de_aniversariantes = Usuario.accessible_by(current_ability).aniversariantes_do_mes.count
    @quantidade_de_projetos = Projeto.accessible_by(current_ability).count
  end
end
