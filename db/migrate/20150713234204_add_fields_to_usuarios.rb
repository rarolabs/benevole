class AddFieldsToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :data_nascimento, :date
    add_column :usuarios, :celular, :string
    add_column :usuarios, :facebook, :string
    add_column :usuarios, :doador_sangue, :boolean
    add_reference :usuarios, :veiculo, index: true, foreign_key: true
    add_column :usuarios, :outros_veiculo, :string
  end
end
