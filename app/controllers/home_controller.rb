class HomeController < ApplicationController
  def index
    @acoes = Acao.order(:created_at)
  end
end
