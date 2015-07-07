class AddEnderecoToUsuarios < ActiveRecord::Migration
  def change
    add_reference :usuarios, :endereco, index: true, foreign_key: true
  end
end
