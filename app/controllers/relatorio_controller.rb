class RelatorioController < ApplicationController

  before_filter :setup

  def show

    @resource = @model
    @q = @resource.search params[:q]
    @q.sorts = 'usuario_id asc'
    @records = @q.result.accessible_by(current_ability).page(params[:page])

    @usuario = Usuario.where(id: @records.map(&:usuario_id).compact.uniq)

  end

  def setup
    @model = Participacao
    @model_permission = @model
    @crud_helper = ParticipacaoCrud
    @url = relatorio_path
    @clean_url = @url
  end

end
