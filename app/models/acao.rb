class Acao < ActiveRecord::Base
  belongs_to :instituicao
  belongs_to :endereco
  belongs_to :projeto
  
  accepts_nested_attributes_for :endereco, :allow_destroy => true
  
  include ActiveModel::Transitions
  state_machine auto_scopes: true, initial: :nova do
    state :nova
    state :em_andamento
    state :concluida
    state :cancelada
    
    event :iniciar do
      transitions from: :nova, to: :em_andamento
    end
    event :concluir do
      transitions from: :em_andamento, :to => :concluida
    end
    event :cancelar do
      transitions from: [:nova, :em_andamento], :to => :cancelada
    end
  end
end
