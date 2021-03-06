class Acao < ActiveRecord::Base
  belongs_to :instituicao
  belongs_to :endereco, dependent: :destroy
  belongs_to :projeto
  has_many :participacoes, dependent: :destroy
  has_many :mensagens, dependent: :destroy
  has_and_belongs_to_many :usuarios
  validates_presence_of :nome, :quantidade_voluntario, :data_inicio, :data_fim, :descricao
  delegate :nome, :to => :projeto, :prefix => true, :allow_nil => true

  accepts_nested_attributes_for :endereco, :allow_destroy => true

  after_save :conclui_acao
  after_commit :confirma_presenca

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

  def participantes
    Usuario.find(participacoes.aceito.pluck(:usuario_id))
  end

  def to_s
    nome
  end

  private
  def conclui_acao
    if self.usuarios.present?
      self.concluir! if self.em_andamento?
    end
  end

  def confirma_presenca
    self.usuarios.each do |usuario|
      usuario.participacoes.aceito.da_acao(self.id).each do |participacao|
        participacao.confirmar_presenca!
      end
    end
  end
end
