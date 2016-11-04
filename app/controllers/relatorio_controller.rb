class RelatorioController < ApplicationController

  before_filter :setup

  def show

    @resource = @model
    @q = @resource.search params[:q]
    @q.sorts = 'usuario_id asc'
    @records = @q.result.accessible_by(current_ability).page(params[:page])
    @usuario = Usuario.where(id: @records.map(&:usuario_id).compact.uniq)
    @percentual = {}

    @usuario.each do |usuario|
      if usuario.participacoes.count.zero? || usuario.participacoes.joins(:acao).where(acoes: {state: "concluida"}).count.zero?
        @percentual[usuario.id] = 0.0
      else
        @percentual[usuario.id] = (usuario.participacoes.where(state: "presente").count.to_f / usuario.participacoes.joins(:acao).where(acoes: {state: "concluida"}).count.to_f  * 100).round(2)
      end
    end
  end

  private
  def setup
    @model = Participacao
    @model_permission = @model
    @crud_helper = ParticipacaoCrud
    @url = relatorio_path
    @clean_url = @url
  end

end
