class Veiculo < ActiveRecord::Base
  belongs_to :instituicao
  validates_presence_of :nome
  def self.outros
    find_by(nome: "Outros") || []
  end

  def to_s
    nome
  end
end
