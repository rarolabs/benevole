class AddMesAniversarioToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :mes_aniversario, :integer
  end
end
