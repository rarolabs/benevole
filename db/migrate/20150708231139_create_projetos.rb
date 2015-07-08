class CreateProjetos < ActiveRecord::Migration
  def change
    create_table :projetos do |t|
      t.string :nome
      t.text :descricao
      t.references :instituicao, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
