class AddTitlesToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :titles, :integer, null: false, default: 0
  end
end
