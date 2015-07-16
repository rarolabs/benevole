class Usuario < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :papel
  belongs_to :instituicao
  belongs_to :endereco
  belongs_to :veiculo
  has_many :participacoes
  
  accepts_nested_attributes_for :endereco, :allow_destroy => true
  acts_as_taggable_on :qualificacao
  mount_uploader :foto, ImageUploader
  
  scope :que_nao_receberam_convite, -> (acao_id) {where("usuarios.id not in (?)", Participacao.where(acao_id: acao_id).pluck(:usuario_id) || [])}
  scope :aniversariantes_do_mes, -> {where("data_nascimento between CAST(? AS DATE) and CAST(? AS DATE)", DateTime.now.beginning_of_month, DateTime.now.end_of_month)}

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
end
