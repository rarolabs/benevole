class Veiculo < ActiveRecord::Base
  belongs_to :instituicao
  
  def to_s
    nome
  end
end
