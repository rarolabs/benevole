class CreateInstituicoes < ActiveRecord::Migration
  def change
    create_table :instituicoes do |t|
      t.string :nome
      t.string :logo
      t.text :descricao
      t.string :site
      t.string :email
      t.references :endereco

      t.timestamps null: false
    end
  end
end
