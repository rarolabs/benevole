class AddTokenToParticipacoes < ActiveRecord::Migration
  def change
    add_column :participacoes, :token, :string
  end
end
