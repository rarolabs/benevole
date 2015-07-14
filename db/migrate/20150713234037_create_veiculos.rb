class CreateVeiculos < ActiveRecord::Migration
  def change
    create_table :veiculos do |t|
      t.string :nome
      t.references :instituicao, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
