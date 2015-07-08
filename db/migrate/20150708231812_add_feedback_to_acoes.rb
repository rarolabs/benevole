class AddFeedbackToAcoes < ActiveRecord::Migration
  def change
    add_column :acoes, :feedback, :text
  end
end
