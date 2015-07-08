class Projeto < ActiveRecord::Base
  belongs_to :instituicao
  has_many :acoes
  def to_s
    nome
  end
end
