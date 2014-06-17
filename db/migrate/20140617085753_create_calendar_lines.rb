class CreateCalendarLines < ActiveRecord::Migration
  def change
    create_table :calendar_lines do |t|
      t.integer :user_id
      t.date :date

      t.timestamps
    end
  end
end
