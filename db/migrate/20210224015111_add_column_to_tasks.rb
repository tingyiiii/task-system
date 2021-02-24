class AddColumnToTasks < ActiveRecord::Migration[6.0]
  def change
    change_column :tasks, :title,       :string,   null: false, unique: true
    change_column :tasks, :description, :text,     null: false
    add_column :tasks, :priority,       :integer,  null: false, default: 0
    add_column :tasks, :status,         :integer,  null: false, default: 0
    add_column :tasks, :start_time,     :datetime, null: false
    add_column :tasks, :end_time,       :datetime, null: false
  end
end
