class Acao < ActiveRecord::Base
  belongs_to :instituicao
  belongs_to :endereco
  
  accepts_nested_attributes_for :endereco, :allow_destroy => true
end
