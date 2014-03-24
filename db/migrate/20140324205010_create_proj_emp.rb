class CreateProjEmp < ActiveRecord::Migration
  def change
    create_table :proj_emps do |t|
      t.belongs_to :employee
      t.belongs_to :project
    end
  end
end
