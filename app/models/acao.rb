class Acao < ActiveRecord::Base
  belongs_to :instituicao
  belongs_to :endereco
  
  accepts_nested_attributes_for :endereco, :allow_destroy => true
  
  include ActiveModel::Transitions
  state_machine auto_scopes: true, initial: :nova do
    state :nova
    state :em_andamento
    state :concluida
    state :cancelada
  end
end
