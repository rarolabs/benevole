class Veiculo < ActiveRecord::Base
  belongs_to :instituicao
  
  def self.outros
    find_by(nome: "Outros") || []
  end

  def to_s
    nome
  end
end
