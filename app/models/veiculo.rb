class Veiculo < ActiveRecord::Base
  belongs_to :instituicao
  
  def self.outros
    find_by(nome: "Outros") || []
  end
  
  def self.com_acesso
    if Usuario.current.present?
      Veiculo.accessible_by(Usuario.current.ability)
    else
      []
    end
  end
  
  def to_s
    nome
  end
end
