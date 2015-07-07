class CreateParticipacoes < ActiveRecord::Migration
  def change
    create_table :participacoes do |t|
      t.references :usuario, index: true, foreign_key: true
      t.references :acao, index: true, foreign_key: true
      t.string :state

      t.timestamps null: false
    end
  end
end
