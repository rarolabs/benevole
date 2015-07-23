class Projeto < ActiveRecord::Base
  belongs_to :instituicao
  has_many :acoes
  
  validates_presence_of :nome, :descricao
  def to_s
    nome
  end
end
