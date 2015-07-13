class CreateCreateJoinTableAcaoToUsuarios < ActiveRecord::Migration
  def change
    create_join_table :acoes, :usuarios, id: false
  end
end
