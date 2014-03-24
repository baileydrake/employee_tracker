class Createcontribution < ActiveRecord::Migration
  def change
    create_table :contributions do |t|
      t.belongs_to :employee
      t.belongs_to :project

      t.timestamps
    end
  end
end
