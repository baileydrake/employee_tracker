class Addcontributionnamecolumn < ActiveRecord::Migration
  def change
    add_column :contributions, :name, :string
  end
end
