class Participacao < ActiveRecord::Base
  belongs_to :usuario
  belongs_to :acao
  
  include ActiveModel::Transitions
  state_machine auto_scopes: true, initial: :convidado do
    state :convidado
    state :aceito
    state :rejeitado

    event :aceitar do
      transitions from: :convidado, to: :aceito
    end
    event :rejeitar do
      transitions from: :convidado, :to => :rejeitado
    end
  end
end
