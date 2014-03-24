class DeleteEmployeeId < ActiveRecord::Migration
  def change
    remove_column :projects, :employee_id, :integer
  end
end
