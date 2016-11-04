class Participacao < ActiveRecord::Base
  belongs_to :usuario
  belongs_to :acao
  delegate :nome, :to => :acao, :allow_nil => false
  validates_uniqueness_of :usuario, scope: :acao
  scope :da_acao, -> (acao_id) {where(acao_id: acao_id)}
  scope :convite_aceito, -> {where(state: "ativa")}
  scope :usuario_presente, -> {where(state: "presente")}


  include ActiveModel::Transitions
  state_machine auto_scopes: true, initial: :convidado do
    state :convidado
    state :aceito
    state :rejeitado
    state :presente

    event :confirmar_presenca do
      transitions from: :aceito, :to => :presente
    end
    event :aceitar do
      transitions from: :convidado, to: :aceito
    end
    event :rejeitar do
      transitions from: :convidado, :to => :rejeitado
    end
  end
  before_create :gerar_token
  after_create :enviar_convite

  def to_s
    acao.nome
  end

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
