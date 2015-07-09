class HomeController < ApplicationController
  def index
    @acoes = Acao.all
  end
end
