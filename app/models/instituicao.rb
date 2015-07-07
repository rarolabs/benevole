class Instituicao < ActiveRecord::Base
  belongs_to :endereco, dependent: :destroy
  has_many :acoes, dependent: :destroy
  has_many :usuarios
  
  validates_presence_of :nome, :descricao
  
  accepts_nested_attributes_for :endereco, :allow_destroy => true
  mount_uploader :logo, ImageUploader
  def to_s
    nome
  end
end
