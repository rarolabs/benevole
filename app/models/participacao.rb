class Participacao < ActiveRecord::Base
  belongs_to :usuario
  belongs_to :acao
  validates_uniqueness_of :usuario, scope: :acao
  
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
  before_create :gerar_token
  after_create :enviar_convite
  
  private
  def gerar_token
    self.token = SecureRandom::uuid
    if Participacao.find_by(token: self.token).present?
      gerar_token
    end
  end
  def enviar_convite
    ConviteMailer.enviar(self.id).deliver_now
  end
end
