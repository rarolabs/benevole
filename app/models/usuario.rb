class Usuario < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :papel
  belongs_to :instituicao
  belongs_to :endereco
  belongs_to :veiculo
  has_many :participacoes

  validates_presence_of :papel, unless: :root?

  accepts_nested_attributes_for :endereco, :allow_destroy => true
  acts_as_taggable_on :qualificacao
  mount_uploader :foto, ImageUploader

  scope :com_nome, -> {where("nome is not null")}
  scope :aniversariantes_do_mes, -> {where(mes_aniversario: DateTime.now.month)}

  before_save :atualiza_mes_aniversario

  def self.que_nao_receberam_convite(acao_id)
    usuarios = Participacao.where(acao_id: acao_id).pluck(:usuario_id)
    if usuarios.present?
      Usuario.com_nome.where("usuarios.id not in (?)", usuarios).order(:nome)
    else
      Usuario.com_nome.order(:nome)
    end
  end

  def to_s
    nome
  end

  def admin?
    self.root? || self.papel.try(:admin?)
  end

  def voluntario?
    self.root? || !self.papel.try(:admin?)
  end

  def self.params_permitt
    [:password, :password_confirmation, :qualificacao_list]
  end

  def ability
    @ability ||= Ability.new(self)
  end

  def self.current
    return Thread.current[:current_usuario]
  end

  def self.current=(usuario)
    Thread.current[:current_usuario] = usuario
  end

  def atualizado?
    nome.present? && foto.present? && data_nascimento.present? && celular.present? && veiculo.present? && endereco.try(:logradouro).try(:present?) && endereco.try(:numero).try(:present?)&& endereco.try(:bairro).try(:present?) && endereco.try(:cidade).try(:present?)
  end

  def atualiza_mes_aniversario
    self.mes_aniversario = self.data_nascimento.month if self.data_nascimento.present?
  end
end
