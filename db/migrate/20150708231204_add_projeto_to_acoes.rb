class AddProjetoToAcoes < ActiveRecord::Migration
  def change
    add_reference :acoes, :projeto, index: true, foreign_key: true
  end
end
