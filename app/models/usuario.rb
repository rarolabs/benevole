class Usuario < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :papel
  belongs_to :instituicao
  belongs_to :endereco
  validates_presence_of :nome, :email
  
  accepts_nested_attributes_for :endereco, :allow_destroy => true
  acts_as_taggable_on :qualificacao
  mount_uploader :foto, ImageUploader

  def to_s
    nome
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
end
