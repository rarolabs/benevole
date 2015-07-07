class CreateAcoes < ActiveRecord::Migration
  def change
    create_table :acoes do |t|
      t.string :nome
      t.references :instituicao, index: true, foreign_key: true
      t.integer :quantidade_voluntario
      t.date :data_inicio
      t.date :data_fim
      t.string :horario
      t.references :endereco, index: true, foreign_key: true
      t.text :descricao
      t.text :observacao
      t.string :state

      t.timestamps null: false
    end
  end
end
