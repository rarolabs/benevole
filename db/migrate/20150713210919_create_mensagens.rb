class CreateMensagens < ActiveRecord::Migration
  def change
    create_table :mensagens do |t|
      t.references :usuario, index: true, foreign_key: true
      t.references :acao, index: true, foreign_key: true
      t.text :texto

      t.timestamps null: false
    end
  end
end
