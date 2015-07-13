class Mensagem < ActiveRecord::Base
  belongs_to :usuario
  belongs_to :acao
end
